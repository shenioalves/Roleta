# 🎡 Roleta TITANICA

A **Roleta TITANICA** é um aplicativo interativo desenvolvido em Flutter, projetado para facilitar a dinâmica de perguntas e respostas de forma divertida e gamificada. O projeto conta com um sistema de administração de perguntas, sorteio aleatório via roleta e persistência local de dados.

## 🚀 Funcionalidades

-   **Roleta Interativa**: Gire a roleta para sortear perguntas de forma dinâmica.
-   **Painel Administrativo**: Interface para adicionar, remover e gerenciar as perguntas disponíveis.
-   **Efeitos Sonoros**: Feedback auditivo para as ações de girar e conclusão do sorteio.
-   **Persistência Local**: Todas as perguntas são salvas localmente, permitindo o uso offline.
-   **Design Moderno**: Interface responsiva e estilizada utilizando Google Fonts e componentes personalizados.

## 🛠️ Tecnologias Utilizadas

-   **[Flutter](https://flutter.dev/)**: Framework para desenvolvimento cross-platform.
-   **[MobX](https://mobx.pub/)**: Gerenciamento de estado reativo e eficiente.
-   **[Hive](https://hivedb.dev/)**: Banco de dados NoSQL leve e rápido para persistência local.
-   **[GetIt](https://pub.dev/packages/get_it)**: Service Locator para injeção de dependências.
-   **[Audioplayers](https://pub.dev/packages/audioplayers)**: Reprodução de efeitos sonoros.
-   **[Google Fonts](https://fonts.google.com/)**: Tipografia personalizada (Poppins).
-   **[Flutter SVG](https://pub.dev/packages/flutter_svg)**: Renderização de ativos vetoriais.

## 🏗️ Arquitetura e Organização

O projeto segue uma estrutura organizada por funcionalidades (**Feature-based**) e utiliza o padrão **MVVM (Model-View-ViewModel)**:

-   **`lib/core/`**: Contém componentes compartilhados, como serviços globais, temas, constantes e o localizador de serviços.
-   **`lib/features/`**: Cada funcionalidade (ex: `questions`) possui sua própria estrutura de:
    -   **Data**: Modelos e repositórios para comunicação com o Hive.
    -   **Presentation**: Views (UI), Widgets e ViewModels (Stores do MobX).
-   **Repositórios**: Camada responsável por abstrair o acesso aos dados.
-   **Stores (MobX)**: Gerenciam o estado da aplicação e a lógica de negócio das telas.

## 📦 Como Executar o Projeto

1.  **Pré-requisitos**: Ter o Flutter instalado em sua máquina.
2.  **Clonar o repositório**:
    ```bash
    git clone https://github.com/shenioalves/roleta.git
    ```
3.  **Instalar dependências**:
    ```bash
    flutter pub get
    ```
4.  **Gerar arquivos do MobX e Hive**:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
5.  **Executar o app**:
    ```bash
    flutter run
    ```

## 📂 Estrutura de Pastas

```text
lib/
├── core/               # Componentes transversais (DI, Theme, Services)
├── features/           # Funcionalidades do app
│   └── questions/      # Feature de perguntas e roleta
│       ├── data/       # Modelos e Repositórios
│       └── presentation/ # UI e ViewModels (Stores)
├── main.dart           # Ponto de entrada
└── hive_registrar.g.dart # Gerado automaticamente pelo Hive
```

---
Desenvolvido com ❤️ por Shênio Alves
