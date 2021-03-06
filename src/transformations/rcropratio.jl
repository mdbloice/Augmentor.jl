"""
`RCropRatio <: ImageTransformation`

Description
============

Crops out the biggest possible area at some random position of
the given image, such that said sub-image satisfies the specified
aspect ratio (i.e. width divided by height).

Usage
======

    RCropRatio()

    RCropRatio(ratio = 1)

Arguments
==========

- **`ratio`** : The ratio of image height to image width that
the output image should satisfy

Methods
========

- **`transform`** : Applies the transformation to the given Image
or set of images

Author(s)
==========

- Christof Stocker (Github: https://github.com/Evizero)

Examples
========

    using Augmentor
    using TestImages

    # load an example image
    img = testimage("lena")

    # Randomly crops the image to a 2:1 aspect ratio
    img_new = transform(RCropRatio(2), img)

see also
=========

`ImageTransformation`, `transform`
"""
immutable RCropRatio <: ImageTransformation
    ratio::Float64

    function RCropRatio(ratio::Real)
        ratio > 0 || throw(ArgumentError("ratio has to be greater than 0"))
        new(Float64(ratio))
    end
end

RCropRatio(; ratio = 1.) = RCropRatio(ratio)

Base.showcompact(io::IO, op::RCropRatio) = print(io, "Crop to random $(op.ratio) aspect ratio.")
multiplier(::RCropRatio) = 1

function transform{T<:AbstractImage}(op::RCropRatio, img::T)
    w = width(img)
    h = height(img)

    nw = floor(Int, h * op.ratio)
    nh = floor(Int, w / op.ratio)
    nw = nw > 1 ? nw : 1
    nh = nh > 1 ? nh : 1

    result = if nw == w || nh == h
        img
    elseif nw < w
        x_max = w - nw + 1
        @assert x_max > 0
        x = rand(1:x_max)
        crop(img, x:(x+nw-1), 1:h)
    elseif nh < h
        y_max = h - nh + 1
        @assert y_max > 0
        y = rand(1:y_max)
        crop(img, 1:w, y:(y+nh-1))
    end::T
    _log_operation!(result, op)
end

