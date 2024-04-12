# Image_Dehazer
This project describes an efficient haze removal method suitable for hardware design aims to obtain fog-free images. The method is based on the atmosphere scattering model and the dark channel prior method, enabling extraction of the atmospheric light of the entire image and the transmission map essential parameters for the recovery model. Instead of relying on a single global atmospheric light for restoring foggy images, the proposed design employs a local atmospheric light estimation method to achieve optimal results. To ensure overall image consistency without blocking artifacts, dynamic adjustment of local atmospheric light is implemented based on global atmospheric light. Additionally, to obtain an accurate transmission map and alleviate the halo effect, a refined estimation method is performed.

![image](https://github.com/NiteshVLSI/Image_Dehazer/assets/84613258/b5e112e8-31b1-4c23-83a5-61d7d9e02ea9)

## GALC unit


<img width="752" alt="image" src="https://github.com/NiteshVLSI/Image_Dehazer/assets/140998787/670dd03b-43fc-4bab-a1d4-e7571232eb56">

## Edge_detection and modified dark channel

<img width="534" alt="image" src="https://github.com/NiteshVLSI/Image_Dehazer/assets/140998787/b38c69fe-ea6b-4691-9d42-f9c9443ce1c7">

## Transmission Map estimation
<img width="745" alt="image" src="https://github.com/NiteshVLSI/Image_Dehazer/assets/140998787/b5d498d8-8b51-4ed4-8675-adb9843e29e7">

## Local Atmospheric Light Calculation Module

![image](https://github.com/NiteshVLSI/Image_Dehazer/assets/84613258/59e999e6-2593-4609-a105-c16f1f14864d)

## Final Schematic
<img width="779" alt="image" src="https://github.com/NiteshVLSI/Image_Dehazer/assets/140998787/ea5a2cdb-36d3-465b-b41c-aab16f2ba211">


## Utilization Report
<img width="623" alt="image" src="https://github.com/NiteshVLSI/Image_Dehazer/assets/140998787/c563ad4f-ddd5-43e8-a6ff-a114e93e937d">


## Results




<table border="1">
    <tr>
        <th>Hazed Image</th>
        <th>Dehazed Image</th>
    </tr>
    <tr>
        <td><img src="https://github.com/NiteshVLSI/Image_Dehazer/assets/140998787/2799188c-a587-442f-8d96-9efb7fc6a678" alt="Hazed Image 1"></td>
        <td><img src="https://github.com/NiteshVLSI/Image_Dehazer/assets/140998787/ea77009a-68d1-4ab0-b95e-63bede83b8f8" alt="Dehazed Image 1"></td>
    </tr>
    <tr>
        <td><img src="https://github.com/NiteshVLSI/Image_Dehazer/assets/140998787/c260a269-6df4-4112-a750-b1aa10492037" alt="Hazed Image 2"></td>
        <td><img src="https://github.com/NiteshVLSI/Image_Dehazer/assets/140998787/8a94a4cf-5acd-4ccb-8d6d-dd0b2fc27dfb" alt="Dehazed Image 2"></td>
    </tr>
    <tr>
        <td><img src="https://github.com/NiteshVLSI/Image_Dehazer/assets/140998787/12ccd837-3514-49d6-bb59-2f7b12118a4b" alt="Hazed Image 3"></td>
        <td><img src="https://github.com/NiteshVLSI/Image_Dehazer/assets/140998787/fa7e7397-0ead-420a-a7c6-193dc70f20b9" alt="Dehazed Image 3"></td>
    </tr>
     <tr>
        <td> <img src="https://github.com/NiteshVLSI/Image_Dehazer/assets/140998787/e7283951-a8c6-4626-b04f-e7ad5cb654f9" alt="Hazed Image 4">
        </td>
        <td><img src="https://github.com/NiteshVLSI/Image_Dehazer/assets/140998787/f24f257b-7141-4879-a5cf-17be7b537c3b" alt="Dehazed Image 4"></td>
    </tr>

     

   
</table>



