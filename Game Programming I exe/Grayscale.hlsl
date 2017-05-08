Texture2D Texture: register(t0);

SamplerState gTriLinearSam{
  Filter = ANISOTROPIC;
}; //SamplerState

float4 main(float4 posH: SV_POSITION,  float2 texo: TEXCOORD): SV_TARGET{
  float4 color = Texture.Sample(gTriLinearSam, texo);
  color.rgb = (color.r + color.g + color.b)/3.0f;

  return color;
} //main