BUILD=build
UPDATE=update.tmp
SOURCEBALL=guacamole-built.tgz
TARGET=freerdp-ubuntu-pcb-backport

all: 
	@echo "This target cannot be built this way. Use:"
	@echo "   'make update' to update the ${TARGET} directory"	
	@echo "   'cd ${TARGET}', then normal make commands to make ${TARGET}"	

update:	
	/bin/rm -rf ${UPDATE}
	/bin/mkdir -p ${UPDATE} && \
	( cd ${UPDATE} && \
	git clone git://git.alex.org.uk/${TARGET}.git && \
	/bin/rm -rf ${TARGET}/.git ) && \
	( if [ -d ${TARGET} ] ; then svn rm --force ${TARGET} ; fi ) && \
	rm -rf ${TARGET} && \
	mv ${UPDATE}/${TARGET} ${TARGET} && \
	(cd ${TARGET} && perl -p -i -e 's/-1ubuntu2flexiant/.2-1flexiant/g;' debian/changelog && \
	../onlypackage libfreerdp1 libfreerdp-plugins-standard ) && \
	svn add ${TARGET} && \
	/bin/rm -rf ${UPDATE}

clean:
	/bin/rm -rf ${BUILD} ${UPDATE}

