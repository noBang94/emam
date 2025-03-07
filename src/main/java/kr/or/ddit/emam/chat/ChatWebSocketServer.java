package kr.or.ddit.emam.chat;

import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint("/chat-ws")
public class ChatWebSocketServer {

    private static Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());
    private static Map<Session, String> userNicknames = new ConcurrentHashMap<>();

    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
        System.out.println("새로운 세션 시작: " + session.getId());
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("메시지 받음: " + message);

        if (message.startsWith("JOIN:")) {
            String nickname = message.substring(5); // "JOIN:" 제거 후 닉네임 저장
            userNicknames.put(session, nickname);
            broadcastUserList();
        } else {
            broadcast(message, session);
        }
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
        userNicknames.remove(session);
        System.out.println("세션 종료: " + session.getId());
        broadcastUserList();
    }

    @OnError
    public void onError(Throwable error) {
        System.err.println("에러 발생: " + error.getMessage());
    }

    private void broadcast(String message, Session senderSession) {
        for (Session session : sessions) {
            if (session.isOpen()) {
                try {
                    session.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private void broadcastUserList() {
        String userList = "USERLIST:" + String.join(",", userNicknames.values());

        for (Session session : sessions) {
            if (session.isOpen()) {
                try {
                    session.getBasicRemote().sendText(userList);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}