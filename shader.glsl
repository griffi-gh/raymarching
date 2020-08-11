#pragma language glsl3
#define MAXSTEP 100
#define MAXDIST 100.
#define HITDIST .01
#define FOV 1

uniform vec3 pos;
//uniform vec2 rot;

float sphereDist(vec3 p,vec4 s){
  return length(p-s.xyz)-s.w;
}
float floorDist(vec3 p){
  return p.y;
}
//float boxDist(vec3 p,vec3 c,vec3 s)
//{
//  return length(max(abs(p+c)-s,0.0));
//}

float dist(vec3 p){
  return min(
    sphereDist(p,vec4(0.,1.,6.,1.)),
    min(
      sphereDist(p,vec4(7.,2.,6.,1.)),
      floorDist(p)
    )
  );
}

float raymarch(vec3 ro,vec3 rd){
  float td=0.;
  for(int i=0; i<MAXSTEP; i++) {
    vec3 cp=ro+rd*td;
    float d=dist(cp);
    td+=d;
    if(d<HITDIST || td>MAXDIST) break;
  }
  return td;
}

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
  vec2 uv=-(screen_coords - love_ScreenSize.xy * 0.5)/love_ScreenSize.y;

  vec3 ro=pos;//vec3(pos.x, 1, pos.y); //ray origin
  vec3 rd=normalize(vec3(uv,FOV)); //ray direction

  float d=raymarch(ro,rd);
  vec3 c=vec3(1-d/25);

  return vec4(c,1);
}