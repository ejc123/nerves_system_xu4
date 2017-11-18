use Mix.Config

version =
  Path.join(__DIR__, "VERSION")
  |> File.read!
  |> String.trim

pkg = :nerves_system_xu4

config pkg, :nerves_env,
  type: :system,
  version: version,
  compiler: :nerves_package,
  artifact_url: [
    "https://github.com/ejc123/#{pkg}/releases/download/v#{version}/#{pkg}-v#{version}.tar.gz",
  ],
  platform: Nerves.System.BR,
  platform_config: [
    defconfig: "nerves_defconfig",
  ],
  checksum: [
    "nerves_defconfig",
    "rootfs_overlay",
    "linux-4.9.defconfig",
    "fwup.conf",
    "boot.ini",
    "post-createfs.sh",
    "VERSION"
  ]
