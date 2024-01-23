# name the portage image
FROM gentoo/portage:latest as portage

# based on stage3 image
FROM gentoo/stage3:musl-hardened

# copy the entire portage volume in
COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

# continue with image build ...
#RUN emerge -qv gdb 

RUN emerge -qv wget

RUN mkdir -p /etc/portage/patches/dev-cpp/scitokens-cpp && \
    wget -O /etc/portage/patches/dev-cpp/scitokens-cpp/fix-vector.patch https://github.com/scitokens/scitokens-cpp/commit/dc23108e79d913eafdce4f36fdbb4f0dbc01a13b.patch

RUN emerge -qv scitokens-cpp 

RUN FEATURES="test" USE="test" CMAKE_CTEST_ARGUMENTS="--verbose" emerge -v scitokens-cpp 

RUN mkdir -p /etc/portage/package.accept_keywords/ && \
    echo "dev-cpp/scitokens-cpp" > /etc/portage/package.accept_keywords/scitokens

#    echo "dev-cpp/nlohmann_json" >> /etc/portage/package.accept_keywords/scitokens
#
#RUN emerge -uv dev-cpp/nlohmann_json

RUN FEATURES="test" USE="test" CMAKE_CTEST_ARGUMENTS="--verbose" emerge -v scitokens-cpp

#RUN echo "sys-libs/musl" > /etc/portage/package.accept_keywords/musl
#RUN emerge -1quv sys-libs/musl

#RUN FEATURES="test" USE="test" CMAKE_CTEST_ARGUMENTS="--verbose" emerge -v scitokens-cpp

#RUN echo "sys-devel/binutils" > /etc/portage/package.accept_keywords/binutils && \
#    echo "sys-devel/binutils-config" >> /etc/portage/package.accept_keywords/binutils
#RUN emerge -1quv sys-devel/binutils sys-devel/binutils-config

#RUN FEATURES="test" USE="test" CMAKE_CTEST_ARGUMENTS="--verbose" emerge -v scitokens-cpp

#RUN emerge --info
