set -ex

main() {
    local svd=freescale/mkw41z512xxx4/MKW41Z4.svd

    local url=http://ds.arm.com/media/resources/db/chip/$svd
    local svd=$(basename $svd)
#    curl -LO $url
    svd2rust -i $svd | dos2unix | rustfmt > src/lib.rs
    rm $svd

    if [ "$TARGET" = "x86_64-unknown-linux-gnu" ]; then
        cargo check
    else
        xargo check --target $TARGET
    fi
}

main

