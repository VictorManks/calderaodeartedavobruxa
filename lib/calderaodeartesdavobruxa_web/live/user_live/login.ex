defmodule CalderaodeartesdavobruxaWeb.UserLive.Login do
  use CalderaodeartesdavobruxaWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="mx-auto max-w-sm space-y-4">
        <div class="text-center">
          <.header>
            <p>Entrar</p>
            <:subtitle>
              <%= if @current_scope do %>
                Você precisa se autenticar novamente para realizar ações sensíveis na sua conta.
              <% else %>
                Não tem uma conta? <.link
                  navigate={~p"/users/register"}
                  class="font-semibold text-brand hover:underline"
                  phx-no-format
                >Cadastre-se</.link> agora.
              <% end %>
            </:subtitle>
          </.header>
        </div>

        <.form
          :let={f}
          for={@form}
          id="login_form_password"
          action={~p"/users/log-in"}
          phx-submit="submit_password"
          phx-trigger-action={@trigger_submit}
        >
          <.input
            readonly={!!@current_scope}
            field={f[:email]}
            type="email"
            label="Email"
            autocomplete="email"
            required
          />
          <.input
            field={@form[:password]}
            type="password"
            label="Senha"
            autocomplete="current-password"
          />
          <.button class="btn btn-primary w-full" name={@form[:remember_me].name} value="true">
            Entrar e permanecer conectado <span aria-hidden="true">→</span>
          </.button>
          <.button class="btn btn-primary btn-soft w-full mt-2">
            Entrar apenas desta vez
          </.button>
        </.form>
      </div>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    email =
      Phoenix.Flash.get(socket.assigns.flash, :email) ||
        get_in(socket.assigns, [:current_scope, Access.key(:user), Access.key(:email)])

    form = to_form(%{"email" => email}, as: "user")

    {:ok, assign(socket, form: form, trigger_submit: false)}
  end

  @impl true
  def handle_event("submit_password", _params, socket) do
    {:noreply, assign(socket, :trigger_submit, true)}
  end

end
