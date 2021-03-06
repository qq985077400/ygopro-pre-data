--闇黒世界－シャドウ・ディストピア－
--Lair of Darkness
--Script by mercury233
--not fully implemented
function c100306022.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--attribute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsFaceup))
	e2:SetValue(ATTRIBUTE_DARK)
	c:RegisterEffect(e2)
	--release replace
	--local e3=Effect.CreateEffect(c)
	--c:RegisterEffect(e3)
	--token
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_RELEASE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetOperation(c100306022.regop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCountLimit(1)
	e5:SetTarget(c100306022.sptg)
	e5:SetOperation(c100306022.spop)
	c:RegisterEffect(e5)
end
function c100306022.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetFlagEffectLabel(100306022)
	if ct then
		c:SetFlagEffectLabel(100306022,ct+eg:GetCount())
	else
		c:RegisterFlagEffect(100306022,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,eg:GetCount())
	end
end
function c100306022.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=e:GetHandler():GetFlagEffectLabel(100306022)
	if ct then
		Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ct,0,0)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,0,0)
	end
end
function c100306022.spop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetFlagEffectLabel(100306022)
	if not ct then return end
	local p=Duel.GetTurnPlayer()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,100306022+100,0,0x4011,1000,1000,3,RACE_FIEND,ATTRIBUTE_DARK,POS_FACEUP_DEFENSE,p) then return end
	local ft=Duel.GetLocationCount(p,LOCATION_MZONE)
	ct=math.min(ct,ft)
	if ct>1 and Duel.IsPlayerAffectedByEffect(p,59822133) then ct=1 end
	for i=1,ct do
		local token=Duel.CreateToken(tp,100306022+100)
		Duel.SpecialSummonStep(token,0,tp,p,false,false,POS_FACEUP_DEFENSE)
	end
	Duel.SpecialSummonComplete()
end
