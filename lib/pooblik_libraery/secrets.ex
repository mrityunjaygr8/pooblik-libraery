defmodule PooblikLibraery.Secrets do
  use AshAuthentication.Secret

  def secret_for(
        [:authentication, :tokens, :signing_secret],
        PooblikLibraery.Accounts.User,
        _opts,
        _context
      ) do
    Application.fetch_env(:pooblik_libraery, :token_signing_secret)
  end
end
