Config = {}

Config.Price = 2000
Config.UnicornSociety = 'society_unicorn'
Config.DrawDistance = 100.0
Config.ShowTime = 60 --Seconds
Config.MoneyThrowAmount = 100


Config.Ped = {
  {label='Stripper 1',type=5, hash='s_f_y_stripper_01'},
  {label='Stripper 2',type=5, hash='s_f_y_stripper_02'},
  {label='Fat Stripper',type=5, hash='a_f_m_fatcult_01'},
  {label='Male Stripper 1',type=5, hash='a_m_y_musclbeac_01'},
  {label='Male Stripper 2',type=5, hash='a_m_m_acult_01'},
  {label='Tracey De Santa',type=5, hash='CS_TracyDiSanto'},
}

Config.Sit = {
  label = 'Sit',
  name = 'anim@heists@prison_heistunfinished_biztarget_idle',
  anim = 'target_idle',
}

Config.MoneyThrowAnim = {
  anim1 = {
    name = 'amb@world_human_cheering@male_a',
    anim = 'base',
  },
  anim2 = {
    name = 'amb@world_human_cheering@male_b',
    anim = 'base',
  },
  anim3 = {
    name = 'amb@world_human_cheering@male_d',
    anim = 'base',
  },
}

--Please keep it at one location.
Config.Salle = {
  mainscene = {
    label = 'Front seat',
    pos = {x=118.25, y=-1301.15, z=28.57, a=210.63},
  }
}

Config.Dict = {
  show1={
    label = 'Lap dance 1',
    name = 'mini@strip_club@lap_dance@ld_girl_a_song_a_p1',
    anim = 'ld_girl_a_song_a_p1_f',
  },
  show2={
    label = 'Lap dance 2',
    name = 'mini@strip_club@lap_dance@ld_girl_a_song_a_p2',
    anim = 'ld_girl_a_song_a_p2_f',
  },
  show3={
    label = 'Lap dance 3',
    name = 'mini@strip_club@private_dance@part2',
    anim = 'priv_dance_p2',
  },
  show4={
    label = 'Lap dance 4',
    name = 'mini@strip_club@private_dance@part3',
    anim = 'priv_dance_p3',
  },
  show5={
    label = 'Lap dance 5',
    name = 'mini@strip_club@private_dance@part1',
    anim = 'priv_dance_p1',
  },
}

Config.Zones = {
  PrivateDance = {
    Label = 'PrivateDance',
    Pos = { x = 119.02, y = -1302.50, z = 28.40},
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 255, g = 187, b = 255 },
    Type  = 23,
  },
  Money1 = {
    Label = 'Money1',
    Pos = {x=114.43, y=-1290.25, z=27.40},
    Size = {x=1.0, y=1.0, z=1.0},
    Color = {r=255,g=187,b=255},
    Type = 23,
  },
  Money2 = {
    Label = 'Money2',
    Pos = {x=115.20, y=-1285.70, z=27.40},
    Size = {x=1.0, y=1.0, z=1.0},
    Color = {r=255,g=187,b=255},
    Type = 23,
  },
  Money3 = {
    Label = 'Money3',
    Pos = {x=110.77, y=-1283.91, z=27.40},
    Size = {x=1.0, y=1.0, z=1.0},
    Color = {r=255,g=187,b=255},
    Type = 23,
  },
}
