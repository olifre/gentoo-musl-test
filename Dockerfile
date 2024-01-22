# name the portage image
FROM gentoo/portage:latest as portage

# based on stage3 image
FROM gentoo/stage3:musl

# copy the entire portage volume in
COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

# continue with image build ...
RUN emerge -qv gdb 

RUN emerge -qv scitokens-cpp 

RUN FEATURES="test" USE="test" emerge -qv scitokens-cpp 
