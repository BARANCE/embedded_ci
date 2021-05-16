# ==== Modules ====

MODULES :=\
Led\

# ==== Build target ====

.PHONY: $(MODULES)
$(MODULES):
	$(MAKE) --directory=$@ coverage

test: $(MODULES)

clean:
	for MODULE in ${MODULES};\
	do \
		${MAKE} --directory=$${MODULE} clean;\
	done