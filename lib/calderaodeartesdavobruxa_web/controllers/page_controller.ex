defmodule CalderaodeartesdavobruxaWeb.PageController do
  use CalderaodeartesdavobruxaWeb, :controller

  def home(conn, _params) do
    conn
    |> put_layout(html: {CalderaodeartesdavobruxaWeb.Layouts, :home})
    |> render(:home)
  end
end
