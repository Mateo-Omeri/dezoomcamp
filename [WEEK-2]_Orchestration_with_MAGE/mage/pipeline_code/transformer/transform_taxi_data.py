import pandas as pd
import inflection

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    #Remove rows where the passenger count is equal to 0 or the trip distance is equal to zero.
    data = data[(data['passenger_count'] != 0) & (data['trip_distance'] != 0)]

    # Convert lpep_pickup_datetime in datetime type
    data['lpep_pickup_datetime'] = pd.to_datetime(data['lpep_pickup_datetime'])

    # Create new column lpep_pickup_date with new data
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    #Rename columns in Camel Case to Snake Case
    data.columns = [inflection.underscore(col) for col in data.columns]

    return data

@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
    assert output['vendor_id'].isin(output['vendor_id']).all(), "Error: vendor_id is not one of the existing values."
    assert (output['passenger_count'] > 0).all(), "Error: passenger_count is not greater than 0."
    assert (output['trip_distance'] > 0).all(), "Error: trip_distance is not greater than 0."
