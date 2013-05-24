// PyMOL default settings file
// automatically included by the make_pov script
#declare RAD = off;

// Set pixel aspect ratio to 1:1
camera {
    right x*ImageWidth/ImageHeight
}


global_settings {
    #if(RAD)
    assumed_gamma 1.0
        radiosity {
            pretrace_start 0.08
            pretrace_end 0.01
            count 150
            nearest_count 10
            error_bound 0.5
            recursion_limit 3
            low_error_factor 0.5
            gray_threshold 0.0
            minimum_reuse 0.005
            maximum_reuse 0.2
            brightness 1
            adc_bailout 0.005
        }
    #end
}
