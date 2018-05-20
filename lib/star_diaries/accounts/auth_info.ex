defmodule StarDiaries.Accounts.AuthInfo do
  @type credentials :: %{
    token: String.t()
  }
  @type info :: %{
    email: String.t(),
    name: String.t()
  }
  @type t :: %__MODULE__{
    provider: String.t(),
    credentials: credentials,
    info: info
  }

  defstruct provider: nil,
            info: %{
              email: nil,
              name: nil
            },
            credentials: %{
              token: nil
            }

  def to_struct(%Ueberauth.Auth{} = auth) do
    %__MODULE__{
      provider: to_string(auth.provider),
      info: %{
        email: auth.info.email,
        name: auth.info.name,
      },
      credentials: %{
        token: auth.credentials.token
      }
    }
  end
end
