package kr.or.ddit.emam.chat;

import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

@ServerEndpoint("/chat-ws")
public class ChatWebSocketServer {

    private static Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
        System.out.println("새로운 세션 시작: " + session.getId());
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("메시지 받음: " + message);
        broadcast(message, session);
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
        System.out.println("세션 종료: " + session.getId());
    }

    @OnError
    public void onError(Throwable error) {
        System.err.println("에러 발생: " + error.getMessage());
    }

    private void broadcast(String message, Session senderSession) {
        for (Session session : sessions) {
            if (session.isOpen() && !session.getId().equals(senderSession.getId())) {
                try {
                    session.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}