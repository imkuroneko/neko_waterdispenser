Config = {}

-- Visualización del qb-target a los dispensadores
Config.label        = 'Dispensador de agua'
Config.icon         = 'fas fa-droplet'

-- Label para progressbar
Config.labelAction  = 'Bebiendo agua...'

-- Cuanto debe llenar
Config.amountThirst = math.random(10, 15)

-- Cuanto debe tardar para beber agua
Config.TimeInMS     = 5500 -- 5.5s

-- Props dispensadores
Config.props = {
    'prop_watercooler',
    'prop_watercooler_dark'
}

Config.OutOfService = 'Este dispensador de agua se encuentra fuera de servicio'