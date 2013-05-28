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
        gray_threshold 0.0
        brightness 1
        // not smaller than 0.0039
        adc_bailout 0.005
        // not lower than 2 for isosurfaces, not bigger than 3
        recursion_limit 3
        // lowers error bound during pretrace, removes blotches (default 0.5)
        low_error_factor 0.5
        // Fraction of screen to follow bounced rays (default 0.015)
        // Too small → rendering gets slow; too high → no natural darkening
        // of crevices as rays get reused
        minimum_reuse 0.015
        maximum_reuse 0.2
        // Min and maxsize of block in mosaic preview during pretrace
        // default 0.08
        // TODO: Is higher or lower better?
        pretrace_start 0.128
        // not smaller than 0.02 (default 0.04)
        pretrace_end 0.04
        count 200
        // Max number of radiosity values to be blended together (default
        // 4, max 20)
        // Smaller than 4 → patchiness
        nearest_count 20
        // lower error bound → more artifacts (requires higher count), but
        // also higher quality
        error_bound 0.2
    }
}

// default texture
#default {
    finish {
        Dull
    }
}

