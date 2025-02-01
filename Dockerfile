FROM ubuntu:24.10@sha256:102bc1874fdb136fc2d218473f03cf84135cb7496fefdb9c026c0f553cfe1b6d AS CodeChecker

RUN apt -qq update \
    && apt install -qq -y \
        python3 \
        python3-pip \
        clang \
        clang-tidy \
        cppcheck \
        g++ \
        build-essential \
        gcc-multilib \
    && apt clean \
    && apt autoremove --yes \
    && rm -rf /var/lib/apt/lists/ /var/lib/cache/ /var/lib/log/ \
    && pip3 install codechecker==6.24.4 --break-system-packages --ignore-installed 

# FIX: `ERROR: ld.so: object 'ldlogger.so' from LD_PRELOAD cannot be preloaded (cannot open shared object file): ignored.`
ENV LD_LIBRARY_PATH=/usr/local/lib/python3.12/dist-packages/codechecker_analyzer/ld_logger/lib/x86_64/
ENV LD_PRELOAD=/usr/local/lib/python3.12/dist-packages/codechecker_analyzer/ld_logger/lib/x86_64/ldlogger.so

ENTRYPOINT [ "CodeChecker" ]
CMD [ "--help" ]