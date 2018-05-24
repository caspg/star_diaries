defmodule StarDiaries.Accounts.AuthInfo do
  @type credentials :: %{
          token: String.t()
        }
  @type info :: %{
          email: String.t(),
          name: String.t(),
          nickname: String.t()
        }
  @type t :: %__MODULE__{
          provider: String.t(),
          uid: String.t(),
          credentials: credentials,
          info: info
        }

  defstruct provider: nil,
            uid: nil,
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
      uid: to_string(auth.uid),
      info: %{
        email: auth.info.email,
        name: auth.info.name,
        nickname: auth.info.nickname
      },
      credentials: %{
        token: auth.credentials.token
      }
    }
  end
end
