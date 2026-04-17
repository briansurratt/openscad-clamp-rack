# Clamp Rack

A parametric wall-mounted rack for storing F-Clamp style bar clamps.

![Alt Text](./images/5%20clamp%20rack.png)

The image above is demonstrates the model as it generates. It is designed to be installed with the holes below the bar slots.

## Design

The rack holds clamps vertically by their bars. It consists of three main components:

- **Fingers** — rounded horizontal pegs that the clamp bars rest on, spaced to match the clamp head width
- **Back plate** — a vertical wall-mount panel with countersunk #8-32 screw holes for mounting
- **Supports** — triangular gussets under each finger for rigidity



## Parameters

These values are selected based on a collection of F-clamps purchased in a variety of North American retailers.  

It could be modified to accomodiate parallel clamps.

| Parameter | Default | Description |
|---|---|---|
| `number_of_clamps` | `5` | Number of clamps the rack holds |
| `bar_thickness` | `7` mm | Diameter of the clamp bar |
| `bar_width` | `20` mm | Width of the clamp bar |
| `head_width` | `21` mm | Width of the clamp head |
| `finger_thickness` | `15` mm | Thickness of the finger pegs |
| `back_depth` | `18` mm | Depth of the back plate from the wall |
| `support_thickness` | `5` mm | the width of the gussets under each finger | 

The default parameter values make this model quite beefy. If you want to experiment with smaller print volumes, start with the follwing parameters:

- `finger_thickness`
- `back_depth`
- `support_thickness`

## Usage

1. Open [main.scad](main.scad) in OpenSCAD
2. Adjust the parameters at the top of the file to fit your clamps
3. Render (F6) and export as STL
4. Mount to a stud or solid backing using #8-32 flat-head screws through the countersunk holes in the back plate

## Dependencies

[BOSL2](https://github.com/BelfrySCAD/BOSL2) is included as a git submodule. After cloning, initialize it with:

```sh
git submodule update --init
```

