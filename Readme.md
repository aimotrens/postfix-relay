
# Postfix SMTP Relay

Ein simples Postfix SMTP Relay als [Docker-Container](https://hub.docker.com/r/t3a6/postfix-relay).


## Konfiguration

Für die Konfiguration sind die wichtigsten Optionen der `main.cf`
von Postfix per Umgebungsvariablen verfügbar gemacht.
Der Name der Umgebungsvariablen für eine Option ist der gleiche,
wie die Postfixoption, allerdings in Großbuchstaben.

Z.B. wird aus aus der Umgebungsvariablen `MESSAGE_SIZE_LIMIT` die Postfixeinstellung `message_size_limit`.

---

Sind die Einstellungsmöglichkeiten über die Umgebungsvariablen nicht
ausreichend, kann natürlich auch eine eigene `main.cf` und `master.cf`
eingebunden werden.
Die beiden Config-Dateien liegen bei diesem Container unter `/config`,
sodass auch einfach ein kompletter Config-Ordner mit Zertifikaten etc.
eingebunden werden kann.


## Verfügbare Umgebungsvariablen

| Variable                  | Standardwert                                            |
| :-                        | :-                                                      |
| `MYHOSTNAME`              | -                                                       |
| `MYNETWORKS`              | 127.0.0.0/8, 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16  |
| `SMTP_TLS_SECURITY_LEVEL` | encrypt                                                 |
| `MESSAGE_SIZE_LIMIT`      | 20971520                                                |
| `RELAYHOST`               | -                                                       |


## Beispiel

Beispiel für eine docker-compose.yml
```yaml
version: "3.7"
  services:
    mail:
      image: t3a6/postfix-relay:latest
      environment:
       MYHOSTNAME: my-domain.com
       MYNETWORKS: 192.168.1.0/24

```
