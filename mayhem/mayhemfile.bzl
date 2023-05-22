"""Generate a file using a template.

It is much more memory-efficient to use a template file than creating the whole
content during the analysis phase.
"""

def mayhemfile(**kwargs):
    _mayhemfile(
        source_file = "{name}.mayhemfile".format(**kwargs),
        **kwargs
    )

def _mayhemfile_impl(ctx):
    ctx.actions.expand_template(
        template = ctx.file._template,
        output = ctx.outputs.source_file,
        substitutions = {
            "{PROJECT}": ctx.attr.project,
            "{TARGET}": ctx.attr.target,
            "{IMAGE}": ctx.attr.image,
            "{COMMAND}": ctx.attr.command,
        },
    )

_mayhemfile = rule(
    implementation = _mayhemfile_impl,
    attrs = {
        "project": attr.string(mandatory = True),
        "target": attr.string(mandatory = True),
        "image": attr.string(mandatory = True),
        "command": attr.string(mandatory = True),
        "_template": attr.label(
            default = ":mytarget.mayhemfile",
            allow_single_file = True,
        ),
        "source_file": attr.output(mandatory = True),
    },
)
