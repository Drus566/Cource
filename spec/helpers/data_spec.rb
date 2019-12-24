RSpec.describe DataHelper, :type => :helper do
    describe '#forced?' do
        it 'not forced' do
            forced_cource = {'cource':{'value':'12','date':'12/12/12','time':'12:12'}}
            ProcessJson.write_data('app/data/cource_data.json', forced_cource) 
            expect(helper.forced?).to eq(nil)
        end

        it 'forced' do
            forced_cource = {'cource':{'value':'12','date':'12/12/12','time':'12:12','forced':true}}
            ProcessJson.write_data('app/data/cource_data.json', forced_cource) 
            expect(helper.forced?).to be true
        end
    end

    describe '#valid_value?' do
        it 'valid' do
            expect(helper.valid_value?('12')).to eq(true)
        end

        it 'not correct' do
            expect(helper.valid_value?('12..')).to eq(false)
        end

        it 'zero' do
            expect(helper.valid_value?('000')).to eq(false)
        end

        it 'empty' do
            expect(helper.valid_value?('')).to eq(false)
        end

        it 'so much value after comma' do
            expect(helper.valid_value?('000.00000')).to eq(false)
        end

        it 'not numeric' do
            expect(helper.valid_value?('asds')).to eq(false)
        end
    end

    describe '#valid_date?' do
        it 'valid' do
            expect(helper.valid_date?('12/12/2080')).to eq(true)
        end

        it 'not correct' do
            expect(helper.valid_date?('12/12/2019')).to eq(false)
        end

        it 'empty' do
            expect(helper.valid_date?('')).to eq(false)
        end

        it 'not valid' do
            expect(helper.valid_date?('12/1222/2019')).to eq(false)
        end
    end

    describe '#valid_time?' do
        it 'valid' do
            expect(helper.valid_time?('12:13', '12/12/2090')).to eq(true)
        end

        it 'empty' do
            expect(helper.valid_time?('', '12/12/2090')).to eq(false)
        end

        it 'not correct' do
            expect(helper.valid_time?('27:13', '12/12/2090')).to eq(false)
        end

        it 'not valid' do
            expect(helper.valid_time?('12/13', '12/12/2090')).to eq(false)
        end
    end
end