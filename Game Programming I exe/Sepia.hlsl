Texture2D Texture: register(t0);

SamplerState gTriLinearSam{
  Filter = ANISOTROPIC;
}; //SamplerState

float4 main(float4 posH: SV_POSITION,  float2 texo: TEXCOORD): SV_TARGET{
  float3 IntensityConverter = {0.299, 0.587, 0.114};
  float4 sepiaConvert = {0.191, -0.054, -0.221, 0.0};
  float4 currFrameSample = Texture.Sample(gTriLinearSam, texo);
  float alpha = currFrameSample.a;
  float Y = dot(IntensityConverter, currFrameSample);
  float4 color = Y + sepiaConvert;
  color.a = alpha;

  return color;
} //main