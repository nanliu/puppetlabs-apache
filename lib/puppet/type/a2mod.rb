Puppet::Type.newtype(:a2mod) do
  @doc = "Manage Apache 2 modules on Debian and Ubuntu"
  ensurable do
    defaultto(:present)

    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end
  end

  newparam(:name, :namevar=>true) do
    desc "The name of the module to be managed"
  end
end
