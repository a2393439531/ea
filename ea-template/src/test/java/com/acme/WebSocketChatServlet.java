package com.acme;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.eclipse.jetty.util.log.Log;
import org.eclipse.jetty.util.log.Logger;
import org.eclipse.jetty.websocket.WebSocket;
import org.eclipse.jetty.websocket.WebSocket.Connection;
import org.eclipse.jetty.websocket.WebSocket.OnTextMessage;
import org.eclipse.jetty.websocket.WebSocketServlet;

public class WebSocketChatServlet extends WebSocketServlet
{
  private static final Logger LOG = Log.getLogger(WebSocketChatServlet.class);
  private final Set<ChatWebSocket> _members;

  public WebSocketChatServlet()
  {
    this._members = new CopyOnWriteArraySet();
  }

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    getServletContext().getNamedDispatcher("default").forward(request, response);
  }

  public WebSocket doWebSocketConnect(HttpServletRequest request, String protocol)
  {
    return new ChatWebSocket();
  }

  class ChatWebSocket implements WebSocket.OnTextMessage
  {
    WebSocket.Connection _connection;

    ChatWebSocket()
    {
    }

    public void onOpen(WebSocket.Connection connection) {
      this._connection = connection;
      WebSocketChatServlet.this._members.add(this);
    }

    public void onMessage(byte frame, byte[] data, int offset, int length)
    {
    }

    public void onMessage(String data)
    {
      if (data.indexOf("disconnect") >= 0) {
        this._connection.disconnect();
      }
      else
      {
        for (ChatWebSocket member : WebSocketChatServlet.this._members)
        {
          try
          {
            member._connection.sendMessage(data);
          }
          catch (IOException e)
          {
            WebSocketChatServlet.LOG.warn(e);
          }
        }
      }
    }

    public void onClose(int code, String message)
    {
      WebSocketChatServlet.this._members.remove(this);
    }
  }
}