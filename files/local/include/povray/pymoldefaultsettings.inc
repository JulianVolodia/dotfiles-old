#include "finish.inc"

// PyMOL default settings file
// automatically included by the make_pov script
global_settings {
    assumed_gamma 1.0
    adc_bailout 0.005
    charset utf8
    // 1 unit in coordinate system = 1 cm
    // To calculate SSLT for different materials
    mm_per_unit 10
    // Only with +q9 or higher
    subsurface {
        // Number of sample rays for diffuse (first value) and single
        // (second value) scattering
        // Lower values -> better performance
        samples 50, 50
        // Use subsurface scattering on radiosity photons
        radiosity on
    }

    radiosity {
        pretrace_start 0.128
        pretrace_end   0.002
        count 500
        nearest_count 20
        error_bound 0.5
        recursion_limit 2
        low_error_factor 1.0
        gray_threshold 0.0
        minimum_reuse 0.005
        maximum_reuse 0.1
        brightness 1
        adc_bailout 0.005
    }
}

// default texture
#default {
    finish {
        Dull
    }
}
