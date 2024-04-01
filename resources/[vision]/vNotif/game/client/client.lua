local Events <const> = {
    CREATE_NOTIFICATION = '__vision::createNotification',
    UPDATE_MICROPHONE = '__vision::updateMicrophone',
    UPDATE_NOTIFICATION_HUD_STATE = '__vision::updateNotificationHudState'
}

local queuedNotifications = {}
local notif_counter = 0

local icons = {
    ["VERT"] = '<svg xmlns="http://www.w3.org/2000/svg" width="9" height="7" viewBox="0 0 9 7" fill="none"><path d="M3.0568 6.86252L0.131797 3.81174C-0.0439322 3.62846 -0.0439322 3.33128 0.131797 3.14798L0.768178 2.48422C0.943907 2.30091 1.22885 2.30091 1.40458 2.48422L3.375 4.53935L7.59542 0.137464C7.77115 -0.0458212 8.05609 -0.0458212 8.23182 0.137464L8.8682 0.801228C9.04393 0.984513 9.04393 1.28169 8.8682 1.46499L3.6932 6.86254C3.51745 7.04582 3.23253 7.04582 3.0568 6.86252Z" fill="white"/></svg>',
    ["ROUGE"] = '<svg xmlns="http://www.w3.org/2000/svg" width="7" height="7" viewBox="0 0 7 7" fill="none"><path d="M1.25732 0L0 1.25732L0.642038 1.89936L2.2293 3.51338L0.642038 5.10064L0 5.71592L1.25732 7L1.89936 6.35796L3.51338 4.74395L5.10064 6.35796L5.71592 7L7 5.71592L6.35796 5.10064L4.74395 3.51338L6.35796 1.89936L7 1.25732L5.71592 0L5.10064 0.642038L3.51338 2.2293L1.89936 0.642038L1.25732 0Z" fill="white"/></svg>',
    ["VIOLET"] = '<svg xmlns="http://www.w3.org/2000/svg" width="8" height="7" viewBox="0 0 8 7" fill="none"><path d="M4.65583 0L4.25453 0.367883L4.84905 0.912895C4.93079 0.998054 4.97167 1.09684 4.97167 1.20925C4.97167 1.32165 4.93079 1.42725 4.84905 1.50219L3.52996 2.73187L3.90153 3.09976L5.25035 1.87007C5.44728 1.6691 5.54389 1.44769 5.54389 1.20925C5.54389 0.970803 5.44728 0.745985 5.25035 0.545012L4.65583 0ZM3.17696 0.688078L2.77566 1.05596L3.00232 1.24672C3.08407 1.32165 3.12494 1.42384 3.12494 1.54988C3.12494 1.67591 3.08407 1.7781 3.00232 1.85304L2.77566 2.0438L3.17696 2.41168L3.38504 2.20389C3.58198 2.00292 3.6823 1.78491 3.6823 1.54988C3.6823 1.30462 3.58198 1.08321 3.38504 0.878832L3.17696 0.688078ZM7.05992 1.22968C6.80353 1.22968 6.56572 1.32165 6.34649 1.50219L4.25453 3.42336L4.65583 3.76399L6.72921 1.87007C6.82211 1.78491 6.93358 1.74063 7.05992 1.74063C7.18625 1.74063 7.29772 1.78491 7.39062 1.87007L7.61728 2.07786L8 1.70998L7.79192 1.50219C7.57269 1.32165 7.32745 1.22968 7.05992 1.22968ZM1.85787 2.23114L0 7L5.20204 5.29684L1.85787 2.23114ZM6.31677 3.27348C6.05666 3.27348 5.81886 3.36545 5.59591 3.54599L5.00511 4.08759L5.40641 4.45547L5.99721 3.91387C6.09011 3.82871 6.19415 3.78443 6.31677 3.78443C6.43939 3.78443 6.55086 3.82871 6.64375 3.91387L7.2457 4.45547L7.63586 4.10462L7.04134 3.54599C6.82211 3.36545 6.57687 3.27348 6.31677 3.27348Z" fill="white"/></svg>',
    ["BLEU"] = '<svg xmlns="http://www.w3.org/2000/svg" width="7" height="9" viewBox="0 0 7 9" fill="none"><path d="M6 5.58464C6 7.11884 5.0342 8.08464 3.5 8.08464C1.9658 8.08464 1 7.11884 1 5.58464C1 3.93828 2.79219 1.71571 3.34184 1.07283C3.3614 1.04999 3.38567 1.03165 3.41299 1.01908C3.4403 1.00651 3.47002 1 3.50009 1C3.53016 1 3.55987 1.00651 3.58719 1.01908C3.6145 1.03165 3.63878 1.04999 3.65833 1.07283C4.20781 1.71571 6 3.93828 6 5.58464Z" stroke="white" stroke-width="1.2" stroke-miterlimit="10"/><path d="M5.02832 5.72314C5.02832 6.05467 4.89662 6.37261 4.6622 6.60703C4.42778 6.84145 4.10984 6.97314 3.77832 6.97314" stroke="white" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/></svg>',
    ["JAUNE"] = '<svg xmlns="http://www.w3.org/2000/svg" width="5" height="16" viewBox="0 0 5 16" fill="none"><path d="M4.27532 5.43359L0.246235 5.93855L0.101963 6.60713L0.893703 6.75316C1.41097 6.87632 1.51302 7.06282 1.40042 7.57833L0.101963 13.68C-0.239366 15.2582 0.286702 16.0007 1.52358 16.0007C2.48246 16.0007 3.59618 15.5573 4.10113 14.9486L4.25596 14.2166C3.90408 14.5263 3.39033 14.6495 3.049 14.6495C2.56516 14.6495 2.38921 14.3099 2.51413 13.7117L4.27532 5.43359Z" fill="white"/><path d="M2.64224 3.51885C3.61394 3.51885 4.40166 2.73113 4.40166 1.75942C4.40166 0.787721 3.61394 0 2.64224 0C1.67053 0 0.882812 0.787721 0.882812 1.75942C0.882812 2.73113 1.67053 3.51885 2.64224 3.51885Z" fill="white"/></svg>',
    ["BLANC"] = '<svg xmlns="http://www.w3.org/2000/svg" width="9" height="8" viewBox="0 0 9 8" fill="none"><path d="M6.21592 2.09998C5.73186 1.64673 5.10368 1.39828 4.43726 1.39887C3.23791 1.39992 2.2025 2.22227 1.91662 3.363C1.89581 3.44604 1.82183 3.50467 1.73622 3.50467H0.848946C0.732848 3.50467 0.644652 3.39927 0.666128 3.28517C1.00115 1.50608 2.56317 0.160156 4.43961 0.160156C5.46848 0.160156 6.40283 0.564843 7.09223 1.22367L7.64524 0.67066C7.87934 0.436559 8.27961 0.60236 8.27961 0.933436V3.00919C8.27961 3.21443 8.11324 3.3808 7.908 3.3808H5.83224C5.50117 3.3808 5.33537 2.98053 5.56947 2.74641L6.21592 2.09998ZM0.971222 4.61951H3.04697C3.37805 4.61951 3.54385 5.01979 3.30975 5.2539L2.6633 5.90035C3.14736 6.35361 3.77558 6.60207 4.44203 6.60146C5.64076 6.60038 6.67658 5.77859 6.9626 4.63735C6.98341 4.55431 7.05739 4.49567 7.143 4.49567H8.03029C8.14639 4.49567 8.23458 4.60107 8.21311 4.71517C7.87807 6.49424 6.31605 7.84016 4.43961 7.84016C3.41074 7.84016 2.47639 7.43547 1.78699 6.77665L1.23398 7.32965C0.999883 7.56375 0.599609 7.39795 0.599609 7.06688V4.99112C0.599609 4.78589 0.765984 4.61951 0.971222 4.61951Z" fill="white"/></svg>',
    ["CLOCHE"] = '<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12" fill="none"><path d="M9.9812 7.77558L9.1652 6.95504V4.93318C9.17605 4.18238 8.91489 3.453 8.42995 2.87973C7.945 2.30645 7.26901 1.928 6.5268 1.81424C6.09604 1.75752 5.65815 1.7933 5.24232 1.91922C4.8265 2.04514 4.44231 2.25829 4.11539 2.54445C3.78847 2.83062 3.52634 3.18321 3.34649 3.5787C3.16663 3.9742 3.07319 4.4035 3.0724 4.83798V6.95504L2.2564 7.77558C2.1539 7.87978 2.08439 8.01189 2.05657 8.15538C2.02874 8.29887 2.04383 8.44738 2.09994 8.58235C2.15605 8.71731 2.25071 8.83274 2.37206 8.9142C2.49342 8.99567 2.6361 9.03956 2.78226 9.04038H4.30546V9.19451C4.32664 9.65473 4.52939 10.0878 4.86928 10.3988C5.20918 10.7098 5.65851 10.8734 6.1188 10.8537C6.57909 10.8734 7.02841 10.7098 7.36831 10.3988C7.7082 10.0878 7.91095 9.65473 7.93213 9.19451V9.04038H9.45533C9.60149 9.03956 9.74417 8.99567 9.86553 8.9142C9.98688 8.83274 10.0815 8.71731 10.1377 8.58235C10.1938 8.44738 10.2089 8.29887 10.181 8.15538C10.1532 8.01189 10.0837 7.87978 9.9812 7.77558ZM7.02546 9.19451C7.00032 9.41256 6.89202 9.61251 6.72312 9.75269C6.55422 9.89288 6.33775 9.9625 6.1188 9.94704C5.89984 9.9625 5.68337 9.89288 5.51447 9.75269C5.34557 9.61251 5.23727 9.41256 5.21213 9.19451V9.04038H7.02546V9.19451ZM3.17666 8.13371L3.7116 7.59878C3.79645 7.51443 3.86376 7.41412 3.90967 7.30364C3.95557 7.19316 3.97916 7.07468 3.97906 6.95504V4.83798C3.97931 4.53216 4.04497 4.22993 4.17164 3.95158C4.2983 3.67322 4.48304 3.42519 4.71346 3.22411C4.94077 3.01815 5.21012 2.86405 5.50287 2.77247C5.79562 2.68089 6.10477 2.65401 6.40893 2.69371C6.9332 2.77883 7.40907 3.05049 7.74893 3.45865C8.0888 3.86682 8.26977 4.38402 8.25853 4.91504V6.95504C8.25784 7.07437 8.28071 7.19265 8.32583 7.30312C8.37095 7.41358 8.43743 7.51406 8.52146 7.59878L9.06093 8.13371H3.17666Z" fill="white"/></svg>',
    ["DOLLAR"] = '<svg xmlns="http://www.w3.org/2000/svg" width="5" height="8" viewBox="0 0 5 8" fill="none"><path d="M3.63209 3.64687L1.75669 3.15313C1.53963 3.09688 1.38855 2.91406 1.38855 2.71094C1.38855 2.45625 1.61777 2.25 1.90082 2.25H3.05211C3.26396 2.25 3.47234 2.30781 3.64598 2.41406C3.75191 2.47812 3.8943 2.4625 3.9846 2.38281L4.58889 1.85156C4.71218 1.74375 4.69482 1.56406 4.55764 1.46875C4.1322 1.16875 3.60084 1.00156 3.05558 1V0.25C3.05558 0.1125 2.93055 0 2.77774 0H2.22207C2.06926 0 1.94423 0.1125 1.94423 0.25V1H1.90082C0.794677 1 -0.0944028 1.85469 0.00804979 2.86875C0.0809821 3.58906 0.692225 4.175 1.46322 4.37813L3.24312 4.84688C3.46018 4.90469 3.61125 5.08594 3.61125 5.28906C3.61125 5.54375 3.38204 5.75 3.09899 5.75H1.9477C1.73585 5.75 1.52747 5.69219 1.35382 5.58594C1.2479 5.52188 1.10551 5.5375 1.01521 5.61719L0.410914 6.14844C0.287624 6.25625 0.304989 6.43594 0.442171 6.53125C0.867609 6.83125 1.39897 6.99844 1.94423 7V7.75C1.94423 7.8875 2.06926 8 2.22207 8H2.77774C2.93055 8 3.05558 7.8875 3.05558 7.75V6.99687C3.86478 6.98281 4.62362 6.55 4.89104 5.86094C5.26439 4.89844 4.63752 3.91094 3.63209 3.64687Z" fill="white"/></svg>',
    ["SYNC"] = '<svg xmlns="http://www.w3.org/2000/svg" width="9" height="8" viewBox="0 0 9 8" fill="none"><path d="M6.21592 2.09998C5.73186 1.64673 5.10368 1.39828 4.43726 1.39887C3.23791 1.39992 2.2025 2.22227 1.91662 3.363C1.89581 3.44604 1.82183 3.50467 1.73622 3.50467H0.848946C0.732848 3.50467 0.644652 3.39927 0.666128 3.28517C1.00115 1.50608 2.56317 0.160156 4.43961 0.160156C5.46848 0.160156 6.40283 0.564843 7.09223 1.22367L7.64524 0.67066C7.87934 0.436559 8.27961 0.60236 8.27961 0.933436V3.00919C8.27961 3.21443 8.11324 3.3808 7.908 3.3808H5.83224C5.50117 3.3808 5.33537 2.98053 5.56947 2.74641L6.21592 2.09998ZM0.971222 4.61951H3.04697C3.37805 4.61951 3.54385 5.01978 3.30975 5.2539L2.6633 5.90035C3.14736 6.35361 3.77558 6.60207 4.44203 6.60146C5.64076 6.60038 6.67658 5.77859 6.9626 4.63735C6.98341 4.55431 7.05739 4.49567 7.143 4.49567H8.03029C8.14639 4.49567 8.23458 4.60107 8.21311 4.71517C7.87807 6.49424 6.31605 7.84016 4.43961 7.84016C3.41074 7.84016 2.47639 7.43547 1.78699 6.77665L1.23398 7.32965C0.999883 7.56375 0.599609 7.39795 0.599609 7.06688V4.99112C0.599609 4.78589 0.765984 4.61951 0.971222 4.61951Z" fill="white"/></svg>',
    ["BURGER"] = '<svg xmlns="http://www.w3.org/2000/svg" width="8" height="7" viewBox="0 0 8 7" fill="none"><path d="M7.25 3.5H0.75C0.551088 3.5 0.360322 3.57902 0.21967 3.71967C0.0790176 3.86032 0 4.05109 0 4.25C0 4.44891 0.0790176 4.63968 0.21967 4.78033C0.360322 4.92098 0.551088 5 0.75 5H7.25C7.44891 5 7.63968 4.92098 7.78033 4.78033C7.92098 4.63968 8 4.44891 8 4.25C8 4.05109 7.92098 3.86032 7.78033 3.71967C7.63968 3.57902 7.44891 3.5 7.25 3.5ZM7.5 5.5H0.5C0.433696 5.5 0.370107 5.52634 0.323223 5.57322C0.276339 5.62011 0.25 5.6837 0.25 5.75V6C0.25 6.26522 0.355357 6.51957 0.542893 6.70711C0.73043 6.89464 0.984784 7 1.25 7H6.75C7.01522 7 7.26957 6.89464 7.45711 6.70711C7.64464 6.51957 7.75 6.26522 7.75 6V5.75C7.75 5.6837 7.72366 5.62011 7.67678 5.57322C7.62989 5.52634 7.5663 5.5 7.5 5.5ZM0.91625 3H7.08375C7.62391 3 7.93719 2.31406 7.62781 1.81437C7 0.8 5.61797 0.0015625 4 0C2.38219 0.0015625 1 0.8 0.372187 1.81422C0.0625 2.31391 0.376094 3 0.91625 3ZM6 1.25C6.04945 1.25 6.09778 1.26466 6.13889 1.29213C6.18 1.3196 6.21205 1.35865 6.23097 1.40433C6.24989 1.45001 6.25484 1.50028 6.2452 1.54877C6.23555 1.59727 6.21174 1.64181 6.17678 1.67678C6.14181 1.71174 6.09727 1.73555 6.04877 1.7452C6.00028 1.75484 5.95001 1.74989 5.90433 1.73097C5.85865 1.71205 5.8196 1.68 5.79213 1.63889C5.76466 1.59778 5.75 1.54945 5.75 1.5C5.75 1.4337 5.77634 1.37011 5.82322 1.32322C5.87011 1.27634 5.9337 1.25 6 1.25ZM4 0.75C4.04945 0.75 4.09778 0.764662 4.13889 0.792133C4.18 0.819603 4.21205 0.858648 4.23097 0.904329C4.24989 0.950011 4.25484 1.00028 4.2452 1.04877C4.23555 1.09727 4.21174 1.14181 4.17678 1.17678C4.14181 1.21174 4.09727 1.23555 4.04877 1.2452C4.00028 1.25484 3.95001 1.24989 3.90433 1.23097C3.85865 1.21205 3.8196 1.18 3.79213 1.13889C3.76466 1.09778 3.75 1.04945 3.75 1C3.75 0.933696 3.77634 0.870107 3.82322 0.823223C3.87011 0.776339 3.9337 0.75 4 0.75ZM2 1.25C2.04945 1.25 2.09778 1.26466 2.13889 1.29213C2.18 1.3196 2.21205 1.35865 2.23097 1.40433C2.24989 1.45001 2.25484 1.50028 2.2452 1.54877C2.23555 1.59727 2.21174 1.64181 2.17678 1.67678C2.14181 1.71174 2.09727 1.73555 2.04877 1.7452C2.00028 1.75484 1.95001 1.74989 1.90433 1.73097C1.85865 1.71205 1.8196 1.68 1.79213 1.63889C1.76466 1.59778 1.75 1.54945 1.75 1.5C1.75 1.4337 1.77634 1.37011 1.82322 1.32322C1.87011 1.27634 1.9337 1.25 2 1.25Z" fill="white"/></svg>',
    ["RMIC"] = '<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12" fill="none"><path d="M9.9812 7.77558L9.1652 6.95504V4.93318C9.17605 4.18238 8.91489 3.453 8.42995 2.87973C7.945 2.30645 7.26901 1.928 6.5268 1.81424C6.09604 1.75752 5.65815 1.7933 5.24232 1.91922C4.8265 2.04514 4.44231 2.25829 4.11539 2.54445C3.78847 2.83062 3.52634 3.18321 3.34649 3.5787C3.16663 3.9742 3.07319 4.4035 3.0724 4.83798V6.95504L2.2564 7.77558C2.1539 7.87978 2.08439 8.01189 2.05657 8.15538C2.02874 8.29887 2.04383 8.44738 2.09994 8.58235C2.15605 8.71731 2.25071 8.83274 2.37206 8.9142C2.49342 8.99567 2.6361 9.03956 2.78226 9.04038H4.30546V9.19451C4.32664 9.65473 4.52939 10.0878 4.86928 10.3988C5.20918 10.7098 5.65851 10.8734 6.1188 10.8537C6.57909 10.8734 7.02841 10.7098 7.36831 10.3988C7.7082 10.0878 7.91095 9.65473 7.93213 9.19451V9.04038H9.45533C9.60149 9.03956 9.74417 8.99567 9.86553 8.9142C9.98688 8.83274 10.0815 8.71731 10.1377 8.58235C10.1938 8.44738 10.2089 8.29887 10.181 8.15538C10.1532 8.01189 10.0837 7.87978 9.9812 7.77558ZM7.02546 9.19451C7.00032 9.41256 6.89202 9.61251 6.72312 9.75269C6.55422 9.89288 6.33775 9.9625 6.1188 9.94704C5.89984 9.9625 5.68337 9.89288 5.51447 9.75269C5.34557 9.61251 5.23727 9.41256 5.21213 9.19451V9.04038H7.02546V9.19451ZM3.17666 8.13371L3.7116 7.59878C3.79645 7.51443 3.86376 7.41412 3.90967 7.30364C3.95557 7.19316 3.97916 7.07468 3.97906 6.95504V4.83798C3.97931 4.53216 4.04497 4.22993 4.17164 3.95158C4.2983 3.67322 4.48304 3.42519 4.71346 3.22411C4.94077 3.01815 5.21012 2.86405 5.50287 2.77247C5.79562 2.68089 6.10477 2.65401 6.40893 2.69371C6.9332 2.77883 7.40907 3.05049 7.74893 3.45865C8.0888 3.86682 8.26977 4.38402 8.25853 4.91504V6.95504C8.25784 7.07437 8.28071 7.19265 8.32583 7.30312C8.37095 7.41358 8.43743 7.51406 8.52146 7.59878L9.06093 8.13371H3.17666Z" fill="white"/></svg>',
    ["VMIC"] = '<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12" fill="none"><path d="M9.9812 7.77558L9.1652 6.95504V4.93318C9.17605 4.18238 8.91489 3.453 8.42995 2.87973C7.945 2.30645 7.26901 1.928 6.5268 1.81424C6.09604 1.75752 5.65815 1.7933 5.24232 1.91922C4.8265 2.04514 4.44231 2.25829 4.11539 2.54445C3.78847 2.83062 3.52634 3.18321 3.34649 3.5787C3.16663 3.9742 3.07319 4.4035 3.0724 4.83798V6.95504L2.2564 7.77558C2.1539 7.87978 2.08439 8.01189 2.05657 8.15538C2.02874 8.29887 2.04383 8.44738 2.09994 8.58235C2.15605 8.71731 2.25071 8.83274 2.37206 8.9142C2.49342 8.99567 2.6361 9.03956 2.78226 9.04038H4.30546V9.19451C4.32664 9.65473 4.52939 10.0878 4.86928 10.3988C5.20918 10.7098 5.65851 10.8734 6.1188 10.8537C6.57909 10.8734 7.02841 10.7098 7.36831 10.3988C7.7082 10.0878 7.91095 9.65473 7.93213 9.19451V9.04038H9.45533C9.60149 9.03956 9.74417 8.99567 9.86553 8.9142C9.98688 8.83274 10.0815 8.71731 10.1377 8.58235C10.1938 8.44738 10.2089 8.29887 10.181 8.15538C10.1532 8.01189 10.0837 7.87978 9.9812 7.77558ZM7.02546 9.19451C7.00032 9.41256 6.89202 9.61251 6.72312 9.75269C6.55422 9.89288 6.33775 9.9625 6.1188 9.94704C5.89984 9.9625 5.68337 9.89288 5.51447 9.75269C5.34557 9.61251 5.23727 9.41256 5.21213 9.19451V9.04038H7.02546V9.19451ZM3.17666 8.13371L3.7116 7.59878C3.79645 7.51443 3.86376 7.41412 3.90967 7.30364C3.95557 7.19316 3.97916 7.07468 3.97906 6.95504V4.83798C3.97931 4.53216 4.04497 4.22993 4.17164 3.95158C4.2983 3.67322 4.48304 3.42519 4.71346 3.22411C4.94077 3.01815 5.21012 2.86405 5.50287 2.77247C5.79562 2.68089 6.10477 2.65401 6.40893 2.69371C6.9332 2.77883 7.40907 3.05049 7.74893 3.45865C8.0888 3.86682 8.26977 4.38402 8.25853 4.91504V6.95504C8.25784 7.07437 8.28071 7.19265 8.32583 7.30312C8.37095 7.41358 8.43743 7.51406 8.52146 7.59878L9.06093 8.13371H3.17666Z" fill="white"/></svg>'
}

-- type: 'DANGER' | 'SUCCESS' | 'WARN' | 'HAPPY'
-- duration: number | in seconds.
-- content: string
-- icon?: string | only SVG for now.
-- to add a special key: ~K KEY | exampel: Press ~K A
-- to add a special color: ~s | example: ~s Hello world~c This is not in color.
local function createNotification(notification)
    table.insert(queuedNotifications, notification)
end

local function toggleNotificationsVisibility(visibility)
    SendNuiMessage({
        type = Events.UPDATE_NOTIFICATION_HUD_STATE,
        data = visibility
    })
end




--- @example
--    exports['vNotif']:createNotification({
--        type = 'SUCCESS',
--        duration = 5, -- In seconds, default:  4
--        content = 'Hello world'
--})


exports('createNotification', createNotification)
exports('toggleNotificationsVisibility', createNotification)

RegisterNetEvent(Events.CREATE_NOTIFICATION)
AddEventHandler(Events.CREATE_NOTIFICATION, createNotification)


RegisterNetEvent(Events.UPDATE_NOTIFICATION_HUD_STATE)
AddEventHandler(Events.UPDATE_NOTIFICATION_HUD_STATE, toggleNotificationsVisibility)



-- ! Only for debug !
-- Citizen.CreateThread(function()
--     createNotification({
--         content = 'Hello hqzd,qzhd ,qzyhd, qzd, qdh, qdh, qdyhqz , world',
--         type = 'SUCCESS',
--         duration = 5,
--         icon = '<path d="M9.50677 3.28355C8.68741 2.51634 7.62408 2.09578 6.49602 2.09677C4.46587 2.09856 2.71323 3.49055 2.22932 5.42147C2.19409 5.56203 2.06886 5.66129 1.92395 5.66129H0.422054C0.225534 5.66129 0.0762439 5.48288 0.112597 5.28974C0.679695 2.27825 3.32373 0 6.5 0C8.24158 0 9.82315 0.685016 10.9901 1.80021L11.9262 0.864133C12.3225 0.467869 13 0.748522 13 1.30894V4.82258C13 5.16999 12.7184 5.45161 12.371 5.45161H8.85732C8.29691 5.45161 8.01626 4.77407 8.41252 4.37778L9.50677 3.28355ZM0.629032 7.54839H4.14268C4.70309 7.54839 4.98374 8.22593 4.58748 8.62222L3.49323 9.71648C4.31259 10.4837 5.376 10.9043 6.50409 10.9033C8.53319 10.9014 10.2865 9.51036 10.7707 7.57858C10.8059 7.43802 10.9311 7.33876 11.0761 7.33876H12.578C12.7745 7.33876 12.9238 7.51717 12.8874 7.71031C12.3203 10.7218 9.67627 13 6.5 13C4.75842 13 3.17685 12.315 2.00989 11.1998L1.07381 12.1359C0.677546 12.5321 0 12.2515 0 11.6911V8.17742C0 7.83001 0.281623 7.54839 0.629032 7.54839Z" fill="white" />'
--     })
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(4000)


--         createNotification({
--             content = 'Hello ~KB',
--             type = 'DANGER',
--             duration = 5,
--             icon = '<path d="M9.50677 3.28355C8.68741 2.51634 7.62408 2.09578 6.49602 2.09677C4.46587 2.09856 2.71323 3.49055 2.22932 5.42147C2.19409 5.56203 2.06886 5.66129 1.92395 5.66129H0.422054C0.225534 5.66129 0.0762439 5.48288 0.112597 5.28974C0.679695 2.27825 3.32373 0 6.5 0C8.24158 0 9.82315 0.685016 10.9901 1.80021L11.9262 0.864133C12.3225 0.467869 13 0.748522 13 1.30894V4.82258C13 5.16999 12.7184 5.45161 12.371 5.45161H8.85732C8.29691 5.45161 8.01626 4.77407 8.41252 4.37778L9.50677 3.28355ZM0.629032 7.54839H4.14268C4.70309 7.54839 4.98374 8.22593 4.58748 8.62222L3.49323 9.71648C4.31259 10.4837 5.376 10.9043 6.50409 10.9033C8.53319 10.9014 10.2865 9.51036 10.7707 7.57858C10.8059 7.43802 10.9311 7.33876 11.0761 7.33876H12.578C12.7745 7.33876 12.9238 7.51717 12.8874 7.71031C12.3203 10.7218 9.67627 13 6.5 13C4.75842 13 3.17685 12.315 2.00989 11.1998L1.07381 12.1359C0.677546 12.5321 0 12.2515 0 11.6911V8.17742C0 7.83001 0.281623 7.54839 0.629032 7.54839Z" fill="white" />'
--         })

--     end
-- end)

CreateThread(function()
    while true do
        Wait(500)
        if #queuedNotifications > 0 and notif_counter < 5 then
            local notification = queuedNotifications[1]
            table.remove(queuedNotifications, 1)
            notification.icon = icons[notification.type]
            notif_counter = notif_counter + 1
            SendNUIMessage({
                action = Events.CREATE_NOTIFICATION,
                data = notification
            })
            SetTimeout((notification.duration or 5) * 1000, function()
                notif_counter = notif_counter - 1
            end)
        end
    end
end)

--test command
RegisterCommand('testnotif', function()
    createNotification({
        type  = 'ILLEGAL',
        name  = "REPORT N°",
        content = "Nouveau report de (  .. tableRepor .. )",
        typeannonce = "ADMINISTRATION",
        labeltype = "ANNONCE",
        duration = 5,
    })
end)