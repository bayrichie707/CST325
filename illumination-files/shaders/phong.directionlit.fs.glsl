precision mediump float;

uniform vec3 uLightDirection;
uniform vec3 uCameraPosition;
uniform sampler2D uTexture;

varying vec2 vTexcoords;
varying vec3 vWorldNormal;
varying vec3 vWorldPosition;

void main(void) {
    // diffuse contribution
    // todo #1 normalize the light direction and store in a separate variable
    vec3 normalizedLightDir = normalize(uLightDirection);
    // todo #2 normalize the world normal and store in a separate variable
    vec3 normalizedWorld = normalize(vWorldNormal);
    // todo #3 calculate the lambert term
    //float lambert = normalize(max(dot(normalizedLightDir, normalizedWorld), 0));
    float lambert = max(dot(normalizedWorld, normalizedLightDir), 0.0);

    // specular contribution
    // todo #4 in world space, calculate the direction from the surface point to the eye (normalized)
    vec3 eyeVector = normalize(uCameraPosition - vWorldPosition);
    // todo #5 in world space, calculate the reflection vector (normalized)
    vec3 reflectionVector = reflect(-eyeVector, normalizedWorld);

    // todo #6 calculate the phong term
    float phongTerm = pow(max(dot(eyeVector, reflectionVector), 0.0), 64.0);
   
    // combine
    // todo #7 apply light and material interaction for diffuse value by using the texture color as the material
    //float diffuse = textureColor * lambert + lightColor
    vec3 diffuseColor = lambert * texture2D(uTexture, vTexcoords).rgb;
    // todo #8 apply light and material interaction for phong, assume phong material color is (0.3, 0.3, 0.3)
    vec3 specularColor = lambert * vec3(0.3,0.3,0.3);

    vec3 albedo = texture2D(uTexture, vTexcoords).rgb;

    vec3 ambient = albedo * 0.1;
    // vec3 diffuseColor = todo
    // vec3 specularColor = todo

    // todo #9
    // add "diffuseColor" and "specularColor" when ready
    vec3 finalColor = ambient + specularColor + diffuseColor; // + diffuseColor + specularColor;

    //gl_FragColor = vec4(finalColor, 1.0);
    //gl_FragColor = vec4(normalizedWorld, 1.0);
    //gl_FragColor = vec4(phongTerm, phongTerm, phongTerm, 1.0);
    //gl_FragColor = vec4(specularColor, 1.0);
    gl_FragColor = vec4(finalColor, 1.0);
}

// EOF 00100001-10