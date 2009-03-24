
;  AMD64 mpn_nior_n
;  Version 1.0.4
;
;  Copyright 2008 Jason Moxham

;  Windows Conversion Copyright 2008 Brian Gladman

;  This file is part of the MPIR Library.
;  The MPIR Library is free software; you can redistribute it and/or modify
;  it under the terms of the GNU Lesser General Public License as published
;  by the Free Software Foundation; either version 2.1 of the License, or (at
;  your option) any later version.
;  The MPIR Library is distributed in the hope that it will be useful, but
;  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
;  License for more details.
;  You should have received a copy of the GNU Lesser General Public License
;  along with the MPIR Library; see the file COPYING.LIB.  If not, write
;  to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;  Boston, MA 02110-1301, USA.

;  Calling interface:
;
;  mp_limb_t __gmpn_<op>_n(    <op> = nior
;     mp_ptr dst,              rcx
;     mp_srcptr src1,          rdx
;     mp_srcptr src2,           r8
;     mp_size_t  len            r9
;  )

%include "..\yasm_mac.inc"

    CPU  Athlon64
    BITS 64

%define T3      r10
%define T4      r11

    LEAF_PROC mpn_nior_n
    movsxd  r9, r9d
    sub     r9, 4
    jb      .2

    xalign  16
.1: mov     r10, [r8+r9*8+24]
    mov     r11, [r8+r9*8+16]
    or      r10, [rdx+r9*8+24]
    or      r11, [rdx+r9*8+16]
    not     r10
    not     r11
    mov     [rcx+r9*8+24], r10
    mov     [rcx+r9*8+16], r11
    mov     T3, [r8+r9*8+8]
    mov     T4, [r8+r9*8]
    or      T3, [rdx+r9*8+8]
    or      T4, [rdx+r9*8]
    not     T3
    not     T4
    mov     [rcx+r9*8+8], T3
    mov     [rcx+r9*8], T4
    sub     r9, 4
    jnc     .1

.2: add     r9, 4
    jz      .3
    mov     r10, [r8+r9*8-8]
    or      r10, [rdx+r9*8-8]
    not     r10
    mov     [rcx+r9*8-8], r10
    dec     r9
    jz      .3
    mov     r10, [r8+r9*8-8]
    or      r10, [rdx+r9*8-8]
    not     r10
    mov     [rcx+r9*8-8], r10
    dec     r9
    jz      .3
    mov     r10, [r8+r9*8-8]
    or      r10, [rdx+r9*8-8]
    not     r10
    mov     [rcx+r9*8-8], r10

.3: ret

    end
