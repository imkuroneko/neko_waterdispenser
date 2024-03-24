Config = {}

Config.qbTargetIcon     = 'fas fa-droplet' -- icon for the option
Config.qbTargetDistance = 1.4              -- distance

Config.VerifyNearby = false                -- if true, will check you are veery nearby of the water dispenser
Config.amountThirst = math.random(10, 15)  -- how much a cup of water will fill
Config.TimeInMS     = 5500                 -- time for exec the action (5.5s)

Config.props = {                           -- on which props will work this
    'prop_watercooler',
    'prop_watercooler_dark'
}