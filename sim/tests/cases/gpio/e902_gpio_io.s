/*Copyright 2018-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
.text
.align 1
.global main
main:

#==============================
# test gpio port a output
#==============================
li  x3,  0x40019004
li  x4,  0xff
sw x4, 0x0(x3)

li  x3,  0x40019008
li  x4,  0x0
sw x4, 0x0(x3)

li  x3,  0x40019000
li  x4,  0xff
sw x4, 0x0(x3)

#==============================
# test gpio port a input
#==============================
li  x3,  0x40019004
li  x4,  0x0
sw x4, 0x0(x3)

li  x3,  0x40019008
li  x4,  0x0
sw x4, 0x0(x3)

li  x3,  0x40019050
lw x5, 0x0(x3)

WAIT_A_IN:
li x6,255
bne x5,x6, WAIT_A_IN
li  x5,  0x0

TEST_PASS:
la  x4,  __exit
jr  x4

