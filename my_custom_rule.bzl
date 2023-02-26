def write_new_file_impl(ctx):
    output_file = ctx.actions.declare_file(ctx.attr.out_file_name + ".txt")
    
    ctx.actions.run_shell(
        inputs     = [ctx.file.my_input_file], 
        outputs    = [output_file],
        command    = "cp $1 $2",
        arguments  = [ctx.file.my_input_file.path, output_file.path]        
    )
    return DefaultInfo(files = depset([output_file]))

write_new_file = rule(
    implementation = write_new_file_impl,
    attrs = {
        "my_input_file": attr.label(allow_single_file = True),
        "out_file_name": attr.string()
    }
)