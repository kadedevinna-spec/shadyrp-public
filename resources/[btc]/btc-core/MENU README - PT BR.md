# Documentação da UI Integrada - btc-core

Este documento detalha o funcionamento do sistema de NUI integrado no `btc-core`. Ele foi desenhado para ser uma base robusta e personalizável para todos os outros scripts do seu servidor, oferecendo uma vasta gama de funcionalidades de UI, incluindo um menu com dois temas visuais distintos e uma barra de progresso independente.

---

## 🚀 Como Usar

Como todos os elementos de UI fazem parte do `btc-core`, não há um recurso separado para instalar. Outros scripts que precisem de criar elementos de UI devem declarar o `btc-core` como dependência.

### 1. Dependência (em outros scripts)

No `fxmanifest.lua` de qualquer recurso que vá usar a UI (ex: `btc-jobs`), certifique-se de que a seguinte linha existe:

```lua
depends 'btc-core'
```

### 2. Acesso às Funções

No início do seu script de cliente `.lua`, obtenha acesso às funções exportadas pelo `btc-core`:

```lua
local CoreUI = exports['btc-core']
```

---

## 📊 Barra de Progresso

Uma barra de progresso simples e visual que pode ser acionada para qualquer ação.

### Chamar a Barra de Progresso

Para exibir a barra de progresso, use a função `showProgressBar`.

-   **Parâmetros:**
    -   `label` (string): O texto exibido acima da barra.
    -   `duration` (número): O tempo total em milissegundos (ms) para a barra ser concluída.
    -   `freezePlayer` (booleano, opcional): Se `true`, o jogador ficará congelado no local durante o processo. O padrão é `false`.
    -   `color` (string, opcional): Um código de cor hexadecimal para a barra (ex: `'#3498db'`). O padrão é a cor definida em `Config.ProgressBarColor`.

-   **Exemplo:**
    ```lua
    -- Mostra uma barra de progresso usando a cor padrão do ficheiro de configuração e congela o jogador.
    CoreUI:showProgressBar('A Fabricar...', 5000, true)

    -- Mostra uma barra de progresso com uma cor azul personalizada, sem congelar o jogador.
    CoreUI:showProgressBar('A Procurar...', 3000, false, '#3498db')
    ```

---

## 📋 Sistema de Menu

### Abrir um Menu

Para abrir um menu, chame a função `openMenu`.

-   **Propriedades Principais do Menu:**
    -   `id` (string): Um ID único para o menu (ex: `'menu_empregos'`).
    -   `title` (string): O texto que aparece no cabeçalho.
    -   `align` (string): A posição inicial do menu. Opções: `'top-left'`, `'top-right'`, `'center'`, etc.
    -   `menuType` (string): O estilo visual do menu.
        -   `'default'` (padrão): Estilo clássico do RedM com texturas e fontes personalizadas.
        -   `'other'`: Um estilo personalizado vintage/em papel.
    -   `elements` (tabela): A lista de elementos que compõem o menu.
-   **Exemplo:**
    ```lua
    CoreUI:openMenu({
        id = 'meu_menu_principal',
        title = 'Saloon',
        align = 'top-left',
        menuType = 'default',
        elements = { /* ... lista de elementos aqui ... */ }
    })
    ```

### Fechar um Menu

Para forçar o fecho do menu, use `closeMenu`:

```lua
CoreUI:closeMenu()
```

### Navegação e Controlos

-   **Rato:** O menu pode ser movido ao clicar e arrastar o seu cabeçalho.
-   **Teclado:**
    -   **Setas Cima/Baixo**: Navegar entre os itens.
    -   **Setas Esquerda/Direita**: Ajustar valores de um `slider`.
    -   **Enter**: Selecionar/ativar um item.
    -   **Backspace / Escape**: Voltar ou fechar o menu.

### Estrutura dos Elementos

(A documentação dos elementos `label`, `description`, `icon`, `money`, `bottom`, e todos os tipos de elementos permanece a mesma.)

---

## 📜 Exemplo Completo do Menu

Este exemplo demonstra como usar os dois layouts de menu (`default` e `other`) e vários tipos de elementos. Pode criar um comando para o testar.

```lua
local CoreUI = exports['btc-core']

RegisterCommand('menuteste', function()
    CoreUI:openMenu({
        id = 'menu_teste_principal',
        title = 'Menu Principal',
        align = 'top-left',
        menuType = 'other', -- Experimente 'default' ou 'other'
        elements = {
            {
                label = 'Armazém Geral',
                icon = 'shop', -- Assume que tem um ficheiro shop.png em images/
                submenu = {
                    id = 'submenu_loja',
                    title = 'Armazém Geral',
                    align = 'top-left', -- Submenus podem ter o seu próprio alinhamento
                    elements = {
                        {
                            label = 'Comprar Poção',
                            description = 'Restaura a sua vida.',
                            icon = 'potion',
                            money = { cash = 50, gold = 2 },
                            bottom = {
                                {label = 'Cura Instantânea', icon = 'health', bar = {80, 100}},
                                {lbar = {25, 100}}
                            },
                            action = function()
                                print('Poção comprada!')
                                CoreUI:showProgressBar('A usar poção...', 2000, true)
                                CoreUI:closeMenu()
                            end
                        }
                    }
                }
            },
            {
                type = 'checkbox',
                label = 'Ativar Notificações',
                checked = true,
                onChanged = function(isChecked)
                    print('Notificações definidas como: ' .. tostring(isChecked))
                end
            },
            {
                type = 'slider',
                label = 'Volume da Música',
                value = 75,
                onChanged = function(val)
                    print('Volume definido como: ' .. math.floor(val))
                end
            },
            {
                type = 'input',
                label = 'Definir Tag do Clã',
                value = 'BTC',
                maxLength = 5,
                onChanged = function(val)
                    print('Tag do clã alterada para: ' .. val)
                end
            },
            {
                label = 'Fechar Menu',
                icon = 'close_door',
                action = function()
                    CoreUI:closeMenu()
                end
            }
        }
    })
end, false)
