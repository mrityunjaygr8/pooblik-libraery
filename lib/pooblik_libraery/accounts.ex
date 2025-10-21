defmodule PooblikLibraery.Accounts do
  use Ash.Domain, otp_app: :pooblik_libraery, extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource PooblikLibraery.Accounts.Token
    resource PooblikLibraery.Accounts.User
  end
end
