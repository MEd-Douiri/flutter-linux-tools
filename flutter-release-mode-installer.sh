#!/bin/bash

#Build flutter_assets folder and AOT (libapp.so) for release mode

###Build bundle
flutter build bundle -v

###Build the kernel snapshot
`which flutter | awk '{ print substr( $0, 1, length($0)-8 ) }'`/cache/dart-sdk/bin/dart \
`which flutter | awk '{ print substr( $0, 1, length($0)-8 ) }'`/cache/dart-sdk/bin/snapshots/frontend_server.dart.snapshot \
            --sdk-root `which flutter | awk '{ print substr( $0, 1, length($0)-8 ) }'`/cache/artifacts/engine/common/flutter_patched_sdk_product/ \
            --target=flutter \
            --no-print-incremental-dependencies \
            -Ddart.vm.profile=false \
            -Ddart.vm.product=true \
            --aot --tfa \
            --packages .packages \
            --output-dill build/kernel_snapshot.dill \
            --verbose \
            --depfile build/kernel_snapshot.d \
            package:$app_name/main.dart
            

###Create libapp.so
 $engine_path/arm/gen_snapshot_linux_x64_release --snapshot_kind=app-aot-elf --elf=build/flutter_assets/libapp.so --strip  build/kernel_snapshot.dill

   
