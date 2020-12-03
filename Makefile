##
## Copyright © 2019 Ben Lynn
## This file is part of blynn-compiler.
##
## blynn-compiler is free software: you can redistribute it and/or
## modify it under the terms of the GNU General Public License as
## published by the Free Software Foundation, only under version 3 of
## the License.
##
## blynn-compiler is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with blynn-compiler.  If not, see
## <https://www.gnu.org/licenses/>.
##

# Prevent rebuilding
VPATH = bin:generated

CC?=clang
CFLAGS:=$(CFLAGS) -D_GNU_SOURCE -std=c99 -ggdb -D WITH_GLIBC=1 -O2

ALL: precisely

vm: vm.c functions/match.c functions/in_set.c functions/numerate_number.c functions/file_print.c functions/require.c | bin
	$(CC) $(CFLAGS) vm.c functions/file_print.c functions/require.c functions/match.c functions/in_set.c functions/numerate_number.c -o bin/vm

pack_blobs: pack_blobs.c functions/match.c functions/file_print.c functions/require.c | bin
	$(CC) $(CFLAGS) pack_blobs.c functions/match.c functions/file_print.c functions/require.c -o bin/pack_blobs

parenthetically: pack_blobs | generated
	./bin/pack_blobs -f blob/parenthetically.source -o generated/parenthetically

exponentially: pack_blobs | generated
	./bin/pack_blobs -f blob/exponentially.source -o generated/exponentially

practically: pack_blobs | generated
	./bin/pack_blobs -f blob/practically.source -o generated/practically

singularity_blob: pack_blobs | generated
	./bin/pack_blobs -f blob/singularity.source -o generated/singularity_blob

raw: vm parenthetically exponentially practically singularity_blob | bin
	./bin/vm --bootstrap \
		-lf generated/parenthetically \
		-lf generated/exponentially \
		-lf generated/practically \
		-lf generated/singularity_blob \
		-lf singularity \
		-lf semantically \
		-lf stringy \
		-lf binary \
		-lf algebraically \
		-lf parity.hs \
		-lf fixity.hs \
		-lf typically.hs \
		-lf classy.hs \
		-lf barely.hs \
		-lf barely.hs \
		-lfr barely.hs \
		-o bin/raw

lonely:lonely.c | bin
	$(CC) $(CFLAGS) generated/lonely.c -o bin/lonely

lonely.c: vm effectively.hs lonely.hs rts.c raw | generated
	cp rts.c generated/lonely.c
	./bin/vm -f lonely.hs -l bin/raw run effectively.hs >> generated/lonely.c

patty: patty.c | bin
	$(CC) $(CFLAGS) generated/patty.c -o bin/patty

patty.c: patty.hs lonely | generated
	cp rts.c generated/patty.c
	./bin/lonely < patty.hs >> generated/patty.c

guardedly: guardedly.c | bin
	$(CC) $(CFLAGS) generated/guardedly.c -o bin/guardedly

guardedly.c: guardedly.hs patty | generated
	cp rts.c generated/guardedly.c
	./bin/patty < guardedly.hs >> generated/guardedly.c

assembly: assembly.c | bin
	$(CC) $(CFLAGS) generated/assembly.c -o bin/assembly

assembly.c: assembly.hs guardedly | generated
	cp rts.c generated/assembly.c
	./bin/guardedly < assembly.hs >> generated/assembly.c

mutually: mutually.c | bin
	$(CC) $(CFLAGS) generated/mutually.c -o bin/mutually

mutually.c: mutually.hs assembly | generated
	cp rts.c generated/mutually.c
	./bin/assembly < mutually.hs >> generated/mutually.c

uniquely: uniquely.c | bin
	$(CC) $(CFLAGS) generated/uniquely.c -o bin/uniquely

uniquely.c: uniquely.hs mutually | generated
	cp rts.c generated/uniquely.c
	./bin/mutually < uniquely.hs >> generated/uniquely.c

virtually: virtually.c | bin
	$(CC) $(CFLAGS) generated/virtually.c -o bin/virtually

virtually.c: virtually.hs uniquely | generated
	cp rts.c generated/virtually.c
	./bin/uniquely < virtually.hs >> generated/virtually.c

marginally: marginally.c | bin
	$(CC) $(CFLAGS) generated/marginally.c -o bin/marginally

marginally.c:marginally.hs virtually | generated
	./bin/virtually < marginally.hs > generated/marginally.c

methodically: methodically.c | bin
	$(CC) $(CFLAGS) generated/methodically.c -o bin/methodically

methodically.c:methodically.hs marginally | generated
	./bin/marginally < methodically.hs > generated/methodically.c

party: party.c | bin
	$(CC) $(CFLAGS) generated/party.c -o bin/party

party.c:party.hs methodically | generated
	./bin/methodically < party.hs > generated/party.c

multiparty: multiparty.c | bin
	$(CC) $(CFLAGS) generated/multiparty.c -o bin/multiparty

multiparty.c:inn/true.Base.hs inn/System.hs inn/Ast.hs inn/Map.hs inn/Parser.hs inn/Kiselyov.hs inn/Unify.hs inn/RTS.hs inn/Compiler.hs inn/party.hs party | generated
	cat inn/true.Base.hs inn/System.hs inn/Ast.hs inn/Map.hs inn/Parser.hs inn/Kiselyov.hs inn/Unify.hs inn/RTS.hs inn/Compiler.hs inn/party.hs | ./bin/party > generated/multiparty.c

party1: party1.c | bin
	$(CC) $(CFLAGS) generated/party1.c -o bin/party1

party1.c:inn/true.Base.hs inn/System.hs inn/Ast.hs inn/Map.hs inn/Parser.hs inn/Kiselyov.hs inn/Unify.hs inn/RTS.hs inn/Compiler1.hs inn/party.hs multiparty | generated
	cat inn/true.Base.hs inn/System.hs inn/Ast.hs inn/Map.hs inn/Parser.hs inn/Kiselyov.hs inn/Unify.hs inn/RTS.hs inn/Compiler1.hs inn/party.hs | ./bin/multiparty > generated/party1.c

party2: party2.c | bin
	$(CC) $(CFLAGS) generated/party2.c -o bin/party2

party2.c:inn/true.Base.hs inn/System1.hs inn/Ast1.hs inn/Map.hs inn/Parser1.hs inn/Kiselyov.hs inn/Unify.hs inn/RTS1.hs inn/Compiler2.hs inn/party.hs party1 | generated
	cat inn/true.Base.hs inn/System1.hs inn/Ast1.hs inn/Map.hs inn/Parser1.hs inn/Kiselyov.hs inn/Unify.hs inn/RTS1.hs inn/Compiler2.hs inn/party.hs | ./bin/party1 > generated/party2.c

party3: party3.c | bin
	$(CC) $(CFLAGS) generated/party3.c -o bin/party3

party3.c:inn/true.Base1.hs inn/System2.hs inn/Ast2.hs inn/Map.hs inn/Parser2.hs inn/Kiselyov.hs inn/Unify.hs inn/RTS2.hs inn/Compiler3.hs inn/party1.hs party2 | generated
	cat inn/true.Base1.hs inn/System2.hs inn/Ast2.hs inn/Map.hs inn/Parser2.hs inn/Kiselyov.hs inn/Unify.hs inn/RTS2.hs inn/Compiler3.hs inn/party1.hs | ./bin/party2 > generated/party3.c

party4: party4.c | bin
	$(CC) $(CFLAGS) generated/party4.c -o bin/party4

party4.c:inn/true.Base1.hs inn/System2.hs inn/Ast3.hs inn/Map.hs inn/Parser3.hs inn/Kiselyov.hs inn/Unify.hs inn/RTS2.hs inn/Compiler4.hs inn/party2.hs party3 | generated
	cat inn/true.Base1.hs inn/System2.hs inn/Ast3.hs inn/Map.hs inn/Parser3.hs inn/Kiselyov.hs inn/Unify.hs inn/RTS2.hs inn/Compiler4.hs inn/party2.hs | ./bin/party3 > generated/party4.c

crossly: crossly.c | bin
	$(CC) $(CFLAGS) generated/crossly.c -o bin/crossly

crossly.c:crossly.hs methodically | generated
	./bin/methodically < crossly.hs > generated/crossly.c

precisely: precisely.c | bin
	$(CC) $(CFLAGS) generated/precisely.c -o bin/precisely

precisely.c:precisely.hs crossly | generated
	./bin/crossly < precisely.hs > generated/precisely.c

# Directories
bin:
	mkdir -p bin

generated:
	mkdir -p generated

.PHONY: clean
clean:
	rm -rf bin/ generated/
