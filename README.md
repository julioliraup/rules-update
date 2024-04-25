# rules-update - pfSense-pkg-suricata
```
Versão: suricata-5.0
```
## Descrição

O **rules-update** é um projeto desenvolvido para automatizar a atualização do IPS/IDS Suricata no pfSense. Ele fornece uma maneira simples e rápida de estudar e aplicar suas rules via interface, garantindo disponibilidade em ambientes em produção e restringindo tudo que for ameaça, excentuando determinadas regras.

## Instalação

Para instalar o **rules-update**, siga os passos abaixo:

1. Na interface web abra **Diagnostics->Command Prompt**.
2. Cole o seguinte comando e pressione Enter:

```bash
curl https://codeload.github.com/julioliraup/rules-update/zip/refs/heads/main -o rules-update.zip && unzip rules-update.zip && cd rules-update-main && sh install.sh
```

para desinstalar execute da mesma forma:
```
cd rules-update-main && sh uninstall.sh
```
