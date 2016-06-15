module Augmentor

using Requires
using Images
using AffineTransforms
using Interpolations

export

    rotate_expand,
    rotate_crop,

    ImageOperation,
        FlipX,
        FlipY,
        Rotate90,
        Rotate180,
        Rotate270,
        Resize,
        CropRatio,
        CropSize,
        RCropSize,
        RCropRatio,
        Crop,
        Zoom,
        Scale,

    multiplier,

    ImageSource,
        DirImageSource,

    Pipeline,
        LinearPipeline,

    transform

include("common.jl")

include("rotate.jl")
include("crop.jl")
include("imageoperation.jl")
include("operations/flipx.jl")
include("operations/flipy.jl")
include("operations/resize.jl")
include("operations/cropratio.jl")
include("operations/cropsize.jl")
include("operations/rcropsize.jl")
include("operations/rcropratio.jl")
include("operations/crop.jl")
include("operations/zoom.jl")
include("operations/scale.jl")
include("operations/rotate90.jl")
include("operations/rotate180.jl")
include("operations/rotate270.jl")

include("imagesource.jl")
include("dirimagesource.jl")

include("pipeline.jl")
include("linearpipeline.jl")

# Lazy loading for package integrations
@require MLDataUtils include("integrations/MLDataUtils.jl")

end

