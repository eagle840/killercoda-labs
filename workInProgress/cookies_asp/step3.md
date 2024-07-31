
# Trigger identity

in `Areas/Identity/Data/DemoIdentityDbContext.cs`

line 17 add:

`builder.HasDefaultSchema("Authentication");`{{copy}}


# Temp turn on authZ on the index page

in `program.cs`, line 12, update to:


`builder.Services.AddRazorPages(options => options.Conventions.AuthorizePage("/Index"));`{{copy}}

