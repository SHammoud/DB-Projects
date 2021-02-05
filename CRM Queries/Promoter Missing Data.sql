select `Contact`.*, `DD`.`lastBookedShowDate` from `Contact`
left join (
    select MAX(`date`) as lastBookedShowDate, `Deal`.`id`, `Deal`.`promoterID` as promoterId from `Deal_Date`
    join `Deal` on `Deal`.`id` = `Deal_Date`.`dealID` group by `Deal`.`promoterID`
) AS DD on `DD`.`promoterId` = `Contact`.`id`
where `Contact`.`disabled` is null
and `Contact`.`isPromoter` = 1
and (
    `Contact`.`name` is null
    or `Contact`.`name` = ''
    or `Contact`.`surname` is null
    or `Contact`.`surname` = ''
    or `Contact`.`email` is null
    or `Contact`.`email` = ''
    or `Contact`.`city` is null
    or `Contact`.`city` = ''
    or `Contact`.`country` is null
    or `Contact`.`country` = ''
    or `Contact`.`postcode` is null
    or `Contact`.`postcode` = ''
    or (
        (`Contact`.`address` is null or `Contact`.`address` = '')
        and (`Contact`.`address2` is null or `Contact`.`address2` = '')
        and (`Contact`.`address3` is null or `Contact`.`address3` = '')
    ) or (
        (`Contact`.`land` is null or `Contact`.`land` = '')
        and (`Contact`.`mobile` is null or `Contact`.`mobile` = '')
        and (`Contact`.`otherPhone` is null or `Contact`.`otherPhone` = '')
    )
)
and `DD`.`lastBookedShowDate` is not null
and `DD`.`lastBookedShowDate` > '2015-01-01'
order by `DD`.`lastBookedShowDate` desc