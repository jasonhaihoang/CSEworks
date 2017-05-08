Texture2D Texture: register(t0);

SamplerState gTriLinearSam{
  Filter = POINT;
}; //SamplerState

float4 main(float4 posH: SV_POSITION,  float2 texo: TEXCOORD): SV_TARGET{
  int width, height;
  Texture.GetDimensions(width, height);
  texo.x = floor(texo.x * (width/8))/(width/8.0f);
  texo.y = floor(texo.y * (height/8))/(height/8.0f);

  return Texture.Sample(gTriLinearSam,  texo);
} //main