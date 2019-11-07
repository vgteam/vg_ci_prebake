# vg_ci_prebake
Prebaked Docker image to speed up VG CI

This repo, coupled with automated Quay builds, produces the `quay.io/vgteam/vg_ci_prebake` Docker image.

This is used to speed up vg CI testing.

It is also used by Toil for its CI testing, since it needs to support running Toil as part of vg's tests anyway.
