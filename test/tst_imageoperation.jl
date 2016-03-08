A = UInt8[200 150; 50 1]
img = grayim(A)

context("ImageOperation") do
    @fact_throws ArgumentError multiplier(FaultyOp())
end

context("FlipX") do
    @fact FlipX <: ImageOperation --> true
    @fact multiplier(FlipX()) --> 2
    op = FlipX()
    @fact op.chance --> 0.5
    op = FlipX(0.7)
    @fact op.chance --> 0.7
    @fact transform(FlipX(0), img) --> img
    @fact transform(FlipX(1), img) --> flipdim(img, "x")
end

context("FlipY") do
    @fact FlipY <: ImageOperation --> true
    @fact multiplier(FlipY()) --> 2
    op = FlipY()
    @fact op.chance --> 0.5
    op = FlipY(0.7)
    @fact op.chance --> 0.7
    @fact transform(FlipY(0), img) --> img
    @fact transform(FlipY(1), img) --> flipdim(img, "y")
end

