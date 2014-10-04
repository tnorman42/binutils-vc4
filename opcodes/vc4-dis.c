/* Disassembler code for VC4.
   Copyright 2012  Free Software Foundation, Inc.
   Contributed by Mark Marshall, markmarshall14@gmail.com

   This file is part of GAS, GDB and the GNU binutils.

   This program is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
   Free Software Foundation; either version 3, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful, but WITHOUT
   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
   more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software Foundation,
   Inc., 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.  */

#define _GNU_SOURCE         /* See feature_test_macros(7) */

#include "sysdep.h"
#include "dis-asm.h"
#include "libiberty.h"
#include "opcode/vc4.h"
#include <assert.h>

static int vc4_decode(bfd_vma memaddr,
		      struct disassemble_info *dis_info)
{
  int status;
  bfd_byte buffer[10];
  char *ll;
  int len, i;

  for (i = 0; i < 5; i++) {
    status = dis_info->read_memory_func(
	    memaddr + i * 2, buffer + i * 2, 2, dis_info);
    if (status != 0)
      break;
  }
  len = i * 2;

  const struct vc4_opcode *op = vc4_get_opcode(vc4_info, buffer, len);
  if (op == NULL) {
    dis_info->fprintf_func(dis_info->stream, "<unknown>");
    return 2;
  }

  ll = vc4_display(vc4_info, op, memaddr, buffer, len);

  dis_info->fprintf_func(dis_info->stream, "%s", ll);

  free(ll);

  return op->length * 2;
}

int
print_insn_vc4 (bfd_vma memaddr, struct disassemble_info *info)
{
  info->bytes_per_line = 10;
  info->bytes_per_chunk = 2;

  vc4_load_opcode_info();

  if (vc4_info == NULL) {
    info->fprintf_func(info->stream, "<unknown>");
    return 2;
  }

  return vc4_decode(memaddr, info);
}
