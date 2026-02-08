<img width=100% src="https://capsule-render.vercel.app/api?type=waving&color=89E051&height=120&section=header"/>

# Noctis Rice - GNOME
zz
Um rice minimalista e funcional para ambientes GNOME. Este projeto personaliza o visual da interface com **Polybar** e **Rofi**, oferecendo uma experiência leve, bonita e eficiente.

---

## Features

- Compatível com **GNOME**
- **Barra personalizada com Polybar**
- **12 temas diferentes**, com mudanças dinâmicas nas cores da barra
- **Menu de internet**
- **Powermenu**
- **Menu de aplicativos** com Rofi

---

## Requisitos

- GNOME instalado (sessão X11 ou XWayland)
- `polybar`, `rofi`, `dbus-x11` (instalados pelo script)
- NetworkManager (`nmcli`) para o menu de Wi-Fi
- Opcional: `pavucontrol` para controle rápido de áudio
- Opcional: `playerctl` para exibir e controlar o player de mídia no centro da barra
- Extensão para ocultar a barra padrão do GNOME  
  https://extensions.gnome.org/extension/545/hide-top-bar/

---

## Instalação

```bash
git clone https://github.com/seu-user/noctis-rice.git
cd noctis-rice
./install.sh
```

---


## Uso

### Iniciar/Relançar a Polybar
```bash
~/.config/polybar/launch.sh
```

### Trocar tema
Abra o powermenu e selecione **Theme**. O script atualiza:
- cores da Polybar
- tema do Rofi (menu, powermenu e seletor de temas)
- papel de parede e imagem do menu

### Menus rápidos
- Clique no ícone de energia para abrir o powermenu
- Clique no ícone de Wi‑Fi para abrir o menu de redes
- Clique com o botão direito no ícone “foguete” para abrir o menu de apps (Rofi)

### O que aparece na barra
| Lado      | Módulos |
|-----------|---------|
| Esquerda  | Overview GNOME, workspaces, janela atual |
| Centro    | Player de mídia (quando há `playerctl` e algo tocando) |
| Direita   | Wi‑Fi, áudio, relógio, powermenu |

## Scripts da Polybar

Os scripts em `~/.config/polybar/scripts/` são usados pela barra:

| Script | Uso |
|--------|-----|
| `menu.sh` | Menu de aplicativos (Rofi), atalho pelo ícone de apps ou `Super + Q` |
| `powermenu.sh` | Menu de energia e troca de tema |
| `rofi-wifi-menu.sh` | Menu de redes Wi‑Fi ao clicar no ícone de rede |
| `player.sh` | Exibe e controla o player de mídia no centro (requer `playerctl`) |

**Script não utilizado por padrão:** `battery.sh` — existe no projeto mas não está ligado em nenhum módulo da barra. Em laptops, você pode ativar o indicador de bateria adicionando um módulo `custom/script` que chame esse script em `config.ini` e incluindo-o em `modules-right`. O script lê `/sys/class/power_supply/BAT0`; em alguns notebooks o caminho pode ser `BAT1` ou outro.

## Atalhos

| Atalho           | Ação                        |
|------------------|-----------------------------|
| `Super + Enter`  | Abrir GNOME Terminal        |
| `Super + Q`      | Abrir o Rofi (menu apps)    |
---

## Desinstalação

```bash
./uninstall.sh
```

Para **remover apenas os atalhos** (Super+Enter e Super+Q) sem desinstalar o rice nem a Polybar:

```bash
./remove_bind.sh
```

## O que é alterado pelo projeto

Durante a instalação, o script aplica as seguintes mudanças:
- Instala `polybar`, `rofi` e `dbus-x11`
- Copia `polybar/` para `~/.config/polybar`
- Adiciona autostart em `~/.config/autostart/polybar.desktop`
- Ajusta caminhos no `config.ini` (expansão de `~`)
- Cria atalhos customizados no GNOME:
  - `Super + Enter` → GNOME Terminal
  - `Super + Q` → menu do Rofi
- Define o tema padrão `purpleEva` e seu wallpaper
- Inicia a Polybar automaticamente

Na desinstalação, o script:
- Remove `~/.config/polybar`
- Remove o autostart da Polybar
- Mata processos da Polybar
- Restaura o wallpaper padrão do GNOME
- Remove os atalhos customizados
- Desinstala `polybar`, `rofi` e `dbus-x11`

---

## 📸 Screenshots

<details>
  <summary> Purple Eva </summary>

  ![Purple Eva](previw/PurpleEva/PurpleEva.jpg)
  ---
  ![Purple Eva 1](previw/PurpleEva/PurpleEva-1.jpg)
  ---
  ![Purple Eva 2](previw/PurpleEva/PurpleEva-2.jpg)
</details>

<details>
  <summary> Red Cross Eva </summary>

  ![Red Cross Eva](previw/RedCrossEva/RedCrossEva.jpg)
  ---
  ![Red Cross Eva 1](previw/RedCrossEva/RedCrossEva-1.jpg)
  ---
  ![Red Cross Eva 2](previw/RedCrossEva/RedCrossEva-2.jpg)
</details>

<details>
  <summary> Musashi </summary>

  ![Musashi](previw/Musashi/Musashi.jpg)
  ---
  ![Musashi 1](previw/Musashi/Musashi-1.jpg)
  ---
  ![Musashi 2](previw/Musashi/Musashi-2.jpg)
</details>

<details>
  <summary> Black Magic </summary>

  ![Black Magic](previw/BlackMagic/BlackMagic.jpg)
  ---
  ![Black Magic 1](previw/BlackMagic/BlackMagic-1.jpg)
  ---
  ![Black Magic 2](previw/BlackMagic/BlackMagic-2.jpg)
</details>

<details>
  <summary> But Why </summary>

  ![But Why](previw/ButWhy/ButWhy.jpg)
  ---
  ![But Why 1](previw/ButWhy/ButWhy-1.jpg)
  ---
  ![But Why 2](previw/ButWhy/ButWhy-2.jpg)
</details>

<details>
  <summary> Chainsaw Girls </summary>

  ![Chainsaw Girls](previw/ChainsawGirls/ChainsawGirls.jpg)
  ---
  ![Chainsaw Girls 1](previw/ChainsawGirls/ChainsawGirls-1.jpg)
  ---
  ![Chainsaw Girls 2](previw/ChainsawGirls/ChainsawGirls-2.jpg)
</details>

<details>
  <summary> Chrollo Sarasa </summary>

  ![Chrollo Sarasa](previw/chrolloSarasa/chrolloSarasa.jpg)
  ---
  ![Chrollo Sarasa 1](previw/chrolloSarasa/chrolloSarasa-1.jpg)
  ---
  ![Chrollo Sarasa 2](previw/chrolloSarasa/chrolloSarasa-2.jpg)
</details>

<details>
  <summary> Death </summary>

  ![Death](previw/death/death.jpg)
  ---
  ![Death 1](previw/death/death-1.jpg)
  ---
  ![Death 2](previw/death/death-2.jpg)
</details>

<details>
  <summary> Full Metal </summary>

  ![Full Metal](previw/fullMetal/fullMetal.jpg)
  ---
  ![Full Metal 1](previw/fullMetal/fullMetal-1.jpg)
  ---
  ![Full Metal 2](previw/fullMetal/fullMetal-2.jpg)
</details>

<details>
  <summary> Hands </summary>

  ![Hands](previw/hands/hands.jpg)
  ---
  ![Hands 1](previw/hands/hands-1.jpg)
  ---
  ![Hands 2](previw/hands/hands-2.jpg)
</details>

<details>
  <summary> Makima </summary>

  ![Makima](previw/Makima/Makima.jpg)
  ---
  ![Makima 1](previw/Makima/Makima-1.jpg)
  ---
  ![Makima 2](previw/Makima/Makima-2.jpg)
</details>

<details>
  <summary> Mc Larem </summary>

  ![Mc Larem](previw/mcLarem/mcLarem.jpg)
  ---
  ![Mc Larem 1](previw/mcLarem/mcLarem-1.jpg)
  ---
  ![Mc Larem 2](previw/mcLarem/mcLarem-2.jpg)
</details>

<details>
  <summary> Mr Robot </summary>

  ![Mr Robot](previw/mrRobot/mrRobot.jpg)
  ---
  ![Mr Robot 1](previw/mrRobot/mrRobot-1.jpg)
  ---
  ![Mr Robot 2](previw/mrRobot/mrRobot-2.jpg)
</details>

<details>
  <summary> Pact Linux </summary>

  ![Pact Linux](previw/PactLinux/PactLinux.jpg)
  ---
  ![Pact Linux 1](previw/PactLinux/PactLinux-1.jpg)
  ---
  ![Pact Linux 2](previw/PactLinux/PactLinux-2.jpg)
</details>

<details>
  <summary> Purple </summary>

  ![Purple](previw/purple/Purple.jpg)
  ---
  ![Purple 1](previw/purple/Purple-1.jpg)
  ---
  ![Purple 2](previw/purple/Purple-2.jpg)
</details>

<details>
  <summary> Silence </summary>

  ![Silence](previw/Silence/Silence.jpg)
  ---
  ![Silence 1](previw/Silence/Silence-1.jpg)
  ---
  ![Silence 2](previw/Silence/Silence-2.jpg)
</details>

<details>
  <summary> Suck Win </summary>

  ![Suck Win](previw/SuckWin/SuckWin.jpg)
  ---
  ![Suck Win 1](previw/SuckWin/SuckWin-1.jpg)
  ---
  ![Suck Win 2](previw/SuckWin/SuckWin-2.jpg)
</details>

<details>
  <summary> Viland Saga </summary>

  ![Viland Saga](previw/VilandSaga/VilandSaga.jpg)
  ---
  ![Viland Saga 1](previw/VilandSaga/VilandSaga-1.jpg)
  ---
  ![Viland Saga 2](previw/VilandSaga/VilandSaga-2.jpg)
</details>

---

### Apoie o Projeto
Se gostou do projeto, deixe uma ⭐ no repositório – sua ajuda faz diferença.

<img width=100% src="https://capsule-render.vercel.app/api?type=waving&color=89E051&height=120&section=footer"/>
