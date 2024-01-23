# name the portage image
FROM gentoo/portage:latest as portage

# based on stage3 image
FROM gentoo/stage3:musl

# copy the entire portage volume in
COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

# continue with image build ...
RUN emerge -qv gdb 

RUN emerge -qv scitokens-cpp 

RUN FEATURES="test" USE="test" emerge -v scitokens-cpp 

RUN mkdir -p /etc/portage/package.accept_keywords/ && echo "dev-cpp/scitokens-cpp" > /etc/portage/package.accept_keywords/scitokens

RUN FEATURES="test" USE="test" emerge -v scitokens-cpp
