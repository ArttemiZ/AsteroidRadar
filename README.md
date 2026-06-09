# ☄️ Asteroid Radar

**FIAP Global Solution 2026.1 — Space Connect**  
Disciplina: Desenvolvimento Cross Platform (Flutter)

---

## Descrição da Solução

O **Asteroid Radar** é um aplicativo Android/iOS desenvolvido em Flutter que monitora em tempo real objetos próximos à Terra (NEOs — Near Earth Objects) utilizando a API oficial da NASA (NeoWs). O app classifica cada asteroide por nível de risco, exibe dados orbitais e físicos detalhados, e permite ao usuário salvar favoritos para acompanhamento.

## Tema Global Solution

**Indústria Espacial** — A solução conecta tecnologia espacial com segurança planetária, democratizando o acesso a dados da NASA para qualquer cidadão acompanhar ameaças potenciais de asteroides.

Alinhamento ODS: **ODS 9** (Inovação e Infraestrutura) e **ODS 11** (Cidades Sustentáveis).

---

## Fluxo de Telas

```
Splash (futuro) → Home → Lista de Asteroides → Detalhe do Asteroide
                              ↓
                         Favoritos
```

| Tela | Descrição |
|---|---|
| **Home** | Apresentação do app com animações e CTA |
| **Lista** | Asteroides dos próximos 7 dias com filtro por risco |
| **Detalhe** | Dados completos: distância, velocidade, diâmetro, magnitude |
| **Favoritos** | Asteroides salvos localmente via SharedPreferences |

---

## API Utilizada

**NASA NeoWs (Near Earth Object Web Service)**  
`https://api.nasa.gov/neo/rest/v1/feed`

- Chave gratuita em: https://api.nasa.gov
- Chave de teste: Trhk9ov5vRQjWZevh3G1SrsnmnOvWmDn0CDHAs29

---

## Arquitetura

O projeto segue **MVVM + Clean Architecture** com separação em 3 camadas:

```
lib/
├── data/         # Acesso remoto (Dio + NASA), modelos de API, repositório
├── domain/       # Entidades, contratos, casos de uso
└── presentation/ # Telas, ViewModels (Provider), componentes reutilizáveis
```

### Decisões Técnicas

- **Provider** para gerenciamento de estado reativo
- **Dio** para consumo HTTP com timeout configurado
- **SharedPreferences** para persistência local de favoritos
- **Google Fonts** (Rajdhani + Source Code Pro) para design system
- **UiState** sealed class para tratamento de Loading/Success/Error/Initial

---

## Dependências

```yaml
dio: ^5.4.0
provider: ^6.1.1
shared_preferences: ^2.2.2
intl: ^0.19.0
google_fonts: ^6.1.0
```

---

## Como Rodar

```bash
flutter pub get
flutter run
```

> Requisito: Flutter 3.x, Dart 3.x

---

## Integrantes

| Nome | RM |
|---|---|
| Inacia dos Santos Silva | RM553401 |
| Tony Khaled Osman | RM553050 |

