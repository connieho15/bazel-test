def _impl(ctx):
  input = [ctx.file.file, ctx.file.source]
  output = ctx.outputs.out

  # The command may only access files declared in inputs.
  ctx.actions.run_shell(
      inputs=input,
      outputs=[output],
      progress_message="Running Unit Test of %s %s" % (input[1].short_path, input[0].short_path),
      command="phpunit --bootstrap %s %s --debug" % (input[1].path, input[0].path)
      )

phpUnit = rule(
    implementation=_impl,
    attrs={
      "file": attr.label(mandatory=True, allow_files=True, single_file=True),
      "source" : attr.label(mandatory=True, allow_files=True, single_file=True)
      },
    outputs={"out": "%{name}.size"},
)